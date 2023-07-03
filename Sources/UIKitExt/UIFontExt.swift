//
//  UIFontExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 23.06.2022..
//  Copyright © 2022 Rika Omega Rika. All rights reserved.
//

import UIKit

extension UIFont {
    public func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
    public func transform(matrix: CGAffineTransform) -> UIFont {
        let fontDescriptor = fontDescriptor
        let transformedDescriptor = fontDescriptor.withMatrix(matrix)
        return UIFont(descriptor: transformedDescriptor, size: pointSize)
    }
}
