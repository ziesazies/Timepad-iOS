//
//  UIColorExtension.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 17/01/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static var backgroundLight: UIColor = UIColor.white
    static var backgroundDark: UIColor = UIColor.black
    static var tabBarLight: UIColor = UIColor.white
    static var tabBarDark: UIColor = UIColor(rgb: 0x070417)
    static var cellBackgroundLight: UIColor = UIColor.white
    static var cellBackgroundDark: UIColor = UIColor(rgb: 0x292639)
    static var textGrayLight: UIColor = UIColor(rgb: 0x4F4F4F)
    static var textGrayDark: UIColor = UIColor(rgb: 0xBDBDBD)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
