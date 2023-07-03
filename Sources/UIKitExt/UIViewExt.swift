//
//  UIViewExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 18/10/2018.
//  Copyright © 2018 100kas d.o.o. All rights reserved.
//

import UIKit

extension UIView {
    public func embedSubview(_ view: UIView, edgeInsets: UIEdgeInsets = .zero) {
        view.frame = bounds
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String:Any] = ["intoView":self, "view":view]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(edgeInsets.left)-[view]-\(edgeInsets.right)-|",
                                                         options:[],
                                                         metrics:nil,
                                                         views:views)
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(edgeInsets.top)-[view]-\(edgeInsets.bottom)-|",
                                                      options:[],
                                                      metrics:nil,
                                                      views:views)
        
        addConstraints(constraints)
        layoutIfNeeded()
    }
    
    public func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
