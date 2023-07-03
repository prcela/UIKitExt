//
//  CGRect+Ext.swift
//  Mind
//
//  Created by Kresimir Prcela on 14/08/2021.
//

import Foundation
import UIKit

extension CGRect
{
    /** Creates a rectangle with the given center and dimensions
    - parameter center: The center of the new rectangle
    - parameter size: The dimensions of the new rectangle
     */
    public init(center: CGPoint, size: CGSize)
    {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
}
