//
//  ActivityCollectionViewCell.swift
//  Leyline
//
//  Created by Alexey Ivlev on 2/6/21.
//

import UIKit

enum ActivityCellState {
    case active
    case inactive
}

class ActivityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actionContainer: UIStackView!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    @IBOutlet weak var actionDescription: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var activityValue: UILabel!
    
    var model: ActivityModel?
    
    private var dashBorder: CAShapeLayer?
    private var state: ActivityCellState = .inactive
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(red: 84 / 225,
                                                green: 120 / 225,
                                                blue: 228 / 225,
                                                alpha: 1).cgColor
        
        let paddedWidth = activityValue.intrinsicContentSize.width + 2 * 25
        activityValue.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
        
        let paddedHeight = activityValue.intrinsicContentSize.height + 2 * 8
        activityValue.heightAnchor.constraint(equalToConstant: paddedHeight).isActive = true
        
        activityValue.backgroundColor = UIColor(red: 255/225, green: 153/225, blue: 0/225, alpha: 1)
        
        activityValue.transform = CGAffineTransform(rotationAngle: .pi / 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch state {
            case .inactive:
                addDashBorder()
            case .active:
                self.dashBorder?.removeFromSuperlayer()
        }
    }
    
    func configureWith(activityModel: ActivityModel) {
        model = activityModel
        
        activityValue.text = "\(activityModel.pointsValue) LLP / Day"
        
        activityImage.image = activityModel.imageLarge
        activityName.text = activityModel.activityName
        
        actionDescription.text = activityModel.actionText
        actionImage.image = activityModel.imageSmall
        
        actionContainer.layer.borderColor = activityModel.inactiveBackgroundColor.cgColor
        
        activityDescription.textColor = activityModel.inactiveBackgroundColor
        
        updateState(.inactive)
    }
    
    func updateState(_ state: ActivityCellState) {
        guard let model = model else { return }
        
        self.state = state
        
        switch state {
            case .active:
                actionContainer.backgroundColor = model.activeBackgroundColor
                actionImage.tintColor = UIColor.white
                actionDescription.textColor = UIColor.white
                activityDescription.text = model.activeDescriptionText
            case .inactive:
                actionContainer.backgroundColor = UIColor.clear
                actionImage.tintColor = model.inactiveBackgroundColor
                actionDescription.textColor = model.inactiveBackgroundColor
                activityDescription.text = model.inactiveDescriptionText
        }
        
        setNeedsLayout()
    }
    
    private func addDashBorder() {
        guard let model = model else { return }
        
        self.dashBorder?.removeFromSuperlayer()
        
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = 2
        dashBorder.strokeColor = model.inactiveBackgroundColor.cgColor
        dashBorder.lineDashPattern = [6, 6] as [NSNumber]
        dashBorder.frame = actionContainer.bounds
        dashBorder.fillColor = nil
        dashBorder.path = UIBezierPath(rect: actionContainer.bounds).cgPath
        actionContainer.layer.addSublayer(dashBorder)
        
        self.dashBorder = dashBorder
    }
}
