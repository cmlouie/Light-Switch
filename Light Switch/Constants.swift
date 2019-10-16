//
//  Constants.swift
//  Light Switch
//
//  Created by Christopher Louie on 2019-10-16.
//  Copyright © 2019 Christopher Louie. All rights reserved.
//

import UIKit

struct Constants {
    static let switchBackgroundWidth: CGFloat = 136.0
    static let switchBackgroundHeight: CGFloat = 404.0
    static let switchBackgroundOffsetY: CGFloat = 238.0
    static let switchHandleWidth: CGFloat = 118.0
    static let switchHandleHeight: CGFloat = 189.0
    static let switchHandleOffsetY: CGFloat = 442.0
    static let handleSwitchpoint: CGFloat = 345.0
    static let handleMaxpoint: CGFloat = 247.0
    static let topTextSpacing: CGFloat = 80.0
    static let leadingImageSpacing: CGFloat = 33.0
    static let imageHeight: CGFloat = 54.0
    static let imageTextSpacing: CGFloat = 26.0
    static let titleDescriptionSpacing: CGFloat = 6.0
    
    static let swipeVelocityThreshold: CGFloat = 800
    static let animationDuration: TimeInterval = 0.2
    
    static let handleColorOff: UIColor = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1.0)
    static let handleColorOn: UIColor = UIColor(red: 254/255, green: 205/255, blue: 0/255, alpha: 1.0)
    static let switchBackgroundColor: UIColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    static let descriptionTextColor: UIColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
    
    static let iconNameOff: String = "Lightbulb Off"
    static let iconNameOn: String = "Lightbulb On"
    static let imageNameOff: String = "Lamp Off"
    static let imageNameOn: String = "Lamp On"
}
