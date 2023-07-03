//
//  UIColorExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 20/08/16.
//  Copyright © 2016 100kas. All rights reserved.
//

import UIKit

extension UIColor
{
    public convenience init(r: UInt, g: UInt, b: UInt, a: UInt) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        assert(a >= 0 && a <= 255, "Invalid alpha component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    public convenience init(netHex:UInt) {
        self.init(r:(netHex >> 16) & 0xff, g:(netHex >> 8) & 0xff, b:netHex & 0xff, a: (netHex >> 24) & 0xff)
    }
    
    public func hex() -> UInt {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let validRange = 0...255
            let iRed = Int(fRed * 255.0).clamped(to: validRange)
            let iGreen = Int(fGreen * 255.0).clamped(to: validRange)
            let iBlue = Int(fBlue * 255.0).clamped(to: validRange)
            let iAlpha = Int(fAlpha * 255.0).clamped(to: validRange)
            
            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return UInt(rgb)
        }
        // Could not extract RGBA components:
        return 0
    }
    
    
    /**
     Create a ligher color
     */
    public func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
    
    /**
     Create a darker color
     */
    public func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    /**
     Try to increase brightness or decrease saturation
     */
    public func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            let newB: CGFloat = max(min(b + (percentage/100.0), 1.0), 0.0)
            return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
        }
        return self
    }
    
    public func lerpTo(dstColor:UIColor, percentage: CGFloat) -> UIColor {
        var h0: CGFloat = 0, s0: CGFloat = 0, b0: CGFloat = 0, a0: CGFloat = 0
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        if self.getHue(&h0, saturation: &s0, brightness: &b0, alpha: &a0),
           dstColor.getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)
        {
            let t = percentage/100
            let h = h0 + t*(h1-h0)
            let s = s0 + t*(s1-s0)
            let b = b0 + t*(b1-b0)
            let a = a0 + t*(a1-a0)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }
        return self
    }
    
    public func lerpToRGB(dstColor:UIColor, percentage: CGFloat) -> UIColor {
        var r0 = CGFloat(0), g0 = CGFloat(0), b0 = CGFloat(0), a0 = CGFloat(0)
        var r1 = CGFloat(0), g1 = CGFloat(0), b1 = CGFloat(0), a1 = CGFloat(0)
        if self.getRed(&r0, green: &g0, blue: &b0, alpha: &a0),
           dstColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        {
            let t = percentage/100
            let r = r0 + t*(r1-r0)
            let g = g0 + t*(g1-g0)
            let b = b0 + t*(b1-b0)
            let a = a0 + t*(a1-a0)
            return UIColor(r: UInt(r*255), g: UInt(g*255), b: UInt(b*255), a: UInt(a*255))
        }
        return self
    }
}

extension Comparable {
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
