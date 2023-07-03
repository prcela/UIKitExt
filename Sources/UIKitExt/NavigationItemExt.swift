//
//  NavigationItemExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 23/02/2020.
//  Copyright © 2020 100kas d.o.o. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    public func setTitle(title:String, subtitle:String) {
        
        let one = UILabel()
        one.text = title
        one.textColor = UIColor.darkText
        one.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        two.textAlignment = .center
        two.textColor = UIColor.darkText
        two.sizeToFit()
        
        
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        
        
        self.titleView = stackView
    }
}
