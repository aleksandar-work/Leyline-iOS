//
//  ViewController.swift
//  Leyline
//
//  Created by Alexey Ivlev on 1/23/21.
//

import UIKit
import FirebaseUI
import Apollo

//Add popup "Congratulations you *** today! You've earned *** points."

class CheckInViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loginButton: UIButton!
    
    //Datasource
    enum Section {
        case main
    }
    private typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, ActivityModel>
    private typealias DataSourceType = UICollectionViewDiffableDataSource<Section, ActivityModel>
    private lazy var dataSource: DataSourceType = {
        setupCollectionViewDataSource()
    }()
    private let reuseIdentifier = "ActivityCollectionViewCell"
    private var currentPoints: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Activities/leyline-blue-notypo")
        let imageView = UIImageView(image: image)
        navigationItem.titleView = imageView
        
        loginButton.isHidden = true
        loginButton.alpha = 0
        
        collectionView.alpha = 0
        collectionView.isHidden = true
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard user != nil else {
                self?.presentAuthFlow()
                
                return
            }
            
            user?.getIDToken(completion: { [weak self] (token, error) in
                guard error == nil, token != nil else {
                    self?.presentAuthFlow()
                    
                    return
                }
                
                self?.refreshUserData()
            })
            
            self?.collectionView.isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.collectionView.alpha = 1.0
                self?.loginButton.alpha = 0
            }
        }
        
        collectionView.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "LeylineHeaderIdentifier")
        
        update()
    }
    
    private func update() {
        var snapshot = SnapshotType()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(activityData(), toSection: .main)
        
        dataSource.apply(snapshot)
    }
    
    private func refreshUserData() {
        Network.shared.apollo.fetch(query: GetUserInfoQuery(), cachePolicy: .fetchIgnoringCacheCompletely) { [weak self] result in
            switch result {
                case .success(let graphQLResult):
                    if let points = graphQLResult.data?.user?.leylinePoints {
                        if let currentPoints = self?.currentPoints, points > currentPoints  {
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                        }
                        
                        self?.navigationItem.rightBarButtonItem?.title = "\(points) leyline"
                        
                        self?.currentPoints = points
                    }
                    
                    if let dailyExerciseAvailable = graphQLResult.data?.user?.dailyExerciseAvailable {
                        let cell = self?.collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
                        if let activityCell = cell as? ActivityCollectionViewCell {
                            activityCell.updateState(dailyExerciseAvailable ? .active : .inactive)
                        }
                    }
                    
                    if let dailySleepAvailable = graphQLResult.data?.user?.dailySleepAvailable {
                        let cell = self?.collectionView.cellForItem(at: IndexPath(row: 1, section: 0))
                        if let activityCell = cell as? ActivityCollectionViewCell {
                            activityCell.updateState(dailySleepAvailable ? .active : .inactive)
                        }
                    }
                    
                case .failure(let error):
                    print("Failure! Error: \(error)")
            }
        }
    }
    
    private func logExercise() {
        Network.shared.apollo.perform(mutation: DailyExerciseMutation()) {[weak self] result in
            switch result {
                case .success(_):
                    self?.refreshUserData()
                case .failure(_):
                    self?.refreshUserData()
            }
        }
    }
    
    private func logSleep() {
        Network.shared.apollo.perform(mutation: DailySleepMutation()) {[weak self] result in
            switch result {
                case .success(_):
                    self?.refreshUserData()
                case .failure(_):
                    self?.refreshUserData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func presentAuthFlow() {
        collectionView.alpha = 0
        collectionView.isHidden = true
        
        loginButton.isHidden = false
        loginButton.alpha = 1.0

        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        
        let providers: [FUIAuthProvider] = [
            FUIEmailAuth(),
            FUIGoogleAuth(authUI: authUI),
            FUIFacebookAuth(authUI: authUI),
            FUIOAuth.twitterAuthProvider(),
        ]
        authUI.providers = providers
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        authViewController.modalPresentationStyle = .overCurrentContext
        present(authViewController, animated: true, completion: nil)
    }
    
    //MARK: - Datasource
    private func setupCollectionViewDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: collectionView)
        { [weak self] (collectionView, indexPath, activityModel) -> UICollectionViewCell? in
            guard let _self = self,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _self.reuseIdentifier,
                                                                for: indexPath) as? ActivityCollectionViewCell else { return nil }
            
            cell.configureWith(activityModel: activityModel)
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "LeylineHeaderIdentifier",
                for: indexPath)
            
            return view
        }
        
        return dataSource
    }
    @IBAction func logout(_ sender: Any) {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        presentAuthFlow()
    }
}

extension CheckInViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 80, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 120)
        }
}

extension CheckInViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let activityCell = cell as? ActivityCollectionViewCell {
            activityCell.updateState(.inactive)
            
            if indexPath.row == 0 {
                logExercise()
            } else if indexPath.row == 1 {
                logSleep()
            }
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

extension CheckInViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // handle user (`authDataResult.user`) and error as necessary
        
        guard error == nil else {
            presentAuthFlow()
            
            return
        }
        
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.collectionView.alpha = 1.0
            self?.loginButton.alpha = 0
        }
    }
    
    func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?) {
        
    }
}

extension CheckInViewController {
    private func activityData() -> [ActivityModel] {
        
        let exercise = ActivityModel(imageLarge: UIImage(named: "Activities/dembell")!,
                                     imageSmall: UIImage(named: "Activities/runner-exercise")!,
                                     activityName: "Daily Exercise",
                                     activeBackgroundColor: UIColor(red: 255/225, green: 153/225, blue: 0/225, alpha: 1),
                                     inactiveBackgroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4),
                                     pointsValue: 10,
                                     actionText: "Daily Exercise",
                                     activeDescriptionText: "Come back every day to get your 10 Leyline points!",
                                     inactiveDescriptionText: "Less than 24hs has passed since last exercise")
        
        let sleep = ActivityModel(imageLarge: UIImage(named: "Activities/moon")!,
                                     imageSmall: UIImage(named: "Activities/daily-sleep")!,
                                     activityName: "Daily Sleep",
                                     activeBackgroundColor: UIColor(red: 84/225, green: 120/225, blue: 228/225, alpha: 1),
                                     inactiveBackgroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4),
                                     pointsValue: 10,
                                     actionText: "Daily Sleep",
                                     activeDescriptionText: "Come back every day to get your 10 Leyline points!",
                                     inactiveDescriptionText: "Less than 24hs has passed since last sleep")
        
        return [exercise, sleep]
    }
}

