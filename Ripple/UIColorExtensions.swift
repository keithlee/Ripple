//
//  UIColorExtensions.swift
//  Ripple
//
//  Created by Keith Lee on 12/19/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public static let rippleNight = UIColor(red: 68/255, green: 75/255, blue: 93/255, alpha: 1)
    public static let rippleGrey = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    public static let rippleGreen = UIColor(red: 107/255, green: 215/255, blue: 164/255, alpha: 1)
    public static let rippleRed = UIColor(red: 240/255, green: 98/255, blue: 78/255, alpha: 1)
    public static let rippleBlue = UIColor(red: 97/255, green: 187/255, blue: 224/255, alpha: 1)
    public static let rippleBeige = UIColor(red: 254/255, green: 213/255, blue: 135/255, alpha: 1)
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
    
    public func rippleGetColor() -> String {
        switch Float(self.components.red) {
        case Float(68)/Float(255):
            return "rippleNight"
        case Float(245)/Float(255):
            return "rippleGrey"
        case Float(107)/Float(255):
            return "rippleGreen"
        case Float(240)/Float(255):
            return "rippleRed"
        case Float(97)/Float(255):
            return "rippleBlue"
        case Float(254)/Float(255):
            return "rippleBeige"
        default:
            return ""
        }
    }
}
