//
//  StackViewExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 31/05/2020.
//  Copyright © 2020 100kas d.o.o. All rights reserved.
//

import UIKit

extension UIStackView {
    
    public func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
