//
//  UIViewController+Ext.swift
//  Mind
//
//  Created by Kresimir Prcela on 14/08/2021.
//

import Foundation
import UIKit

extension UIViewController {
    public func add(asChildViewController childVC: UIViewController, toView: UIView) {
        // Add Child View Controller
        addChild(childVC)
        
        // Add Child View as Subview
        toView.addSubview(childVC.view)
        
        // Configure Child View
        childVC.view.frame = toView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        childVC.didMove(toParent: self)
    }
    
    public func remove(asChildViewController childVC: UIViewController) {
        // Notify Child View Controller
        childVC.willMove(toParent: nil)
        
        // Remove Child View From Superview
        childVC.view.removeFromSuperview()
        
        // Notify Child View Controller
        childVC.removeFromParent()
    }
}
