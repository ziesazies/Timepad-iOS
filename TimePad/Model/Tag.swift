//
//  Tag.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 24/02/23.
//

import UIKit

enum Tag: CaseIterable{
    case personal
    case work
    
    var name: String {
        switch self {
        case .personal:
            return "Personal"
        case .work:
            return "Work"
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .personal:
            return UIColor(rgb: 0xBDBDBD)
        case .work:
            return UIColor(rgb: 0xFD5B71)
        }
    }
    
    var backgroundColor: UIColor {
        switch self{
        case .personal:
            return UIColor(rgb: 0xF2F2F2)
        case .work:
            return UIColor(rgb: 0xFFEFF1)
        }
    }
    
    var darkBackgroundColor: UIColor {
        switch self {
        case.personal:
            return UIColor(rgb: 0x3F3C4E)
        case .work:
            return UIColor(rgb: 0x3E2B3E)
        }
    }
}
