//
//  UIViewControllerExtensions.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 17/01/23.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, view: UIView? = nil) {
        let containerView: UIView! = view ?? self.view
        addChild(child)
        containerView?.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
