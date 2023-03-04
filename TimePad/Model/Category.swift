//
//  Category.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 23/02/23.
//

import UIKit

enum Category: CaseIterable {
    case project
    case workout
    case coding
    case reading
    
    var name: String {
        switch self {
        case .project:
            return "Project"
        case .workout:
            return "Workout"
        case .coding:
            return "Coding"
        case .reading:
            return "Reading"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .project:
            return UIImage(named: "icon_project")!
        case .workout:
            return UIImage(named: "icon_workout")!
        case .coding:
            return UIImage(named: "icon_coding")!
        case .reading:
            return UIImage(named: "icon_reading")!
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .project:
            return UIColor(rgb: 0x9B51E0)
        case .workout:
            return UIColor(rgb: 0xFFA656)
        case .coding:
            return UIColor(rgb: 0xFD5B71)
        case .reading:
            return UIColor(rgb: 0x07E092)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .project:
            return UIColor(rgb: 0xF5EEFC)
        case .workout:
            return UIColor(rgb: 0xFEF5ED)
        case .coding:
            return UIColor(rgb: 0xFFEFF1)
        case .reading:
            return UIColor(rgb: 0xE6FCF4)
        }
    }
    
    var backgroundDarkColor: UIColor {
        switch self{
        case .project:
            return UIColor(rgb: 0x342A49)
        case .workout:
            return UIColor(rgb: 0x3D313A)
        case .coding:
            return UIColor(rgb: 0xFD5B71).withAlphaComponent(0.1)
        case .reading:
            return UIColor(rgb: 0x29333D)
        }
    }
}
