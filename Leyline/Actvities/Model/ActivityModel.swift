//
//  ActivityModel.swift
//  Leyline
//
//  Created by Alexey Ivlev on 2/6/21.
//

import UIKit

struct ActivityModel: Hashable {
    let imageLarge: UIImage
    let imageSmall: UIImage
    let activityName: String
    let activeBackgroundColor: UIColor
    let inactiveBackgroundColor: UIColor
    let pointsValue: Int
    let actionText: String
    let activeDescriptionText: String
    let inactiveDescriptionText: String
}
