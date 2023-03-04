//
//  BaseViewController.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 25/01/23.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        setupColor()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                setupColor()
            }
        }
        else {
            
        }
    }
    
    func setupColor() {
        if #available(iOS 12.0, *) {
            view.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.backgroundDark : UIColor.backgroundLight
        } else {
            view.backgroundColor = UIColor.backgroundLight
        }
    }
}
