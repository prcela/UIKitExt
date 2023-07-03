//
//  StringExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 02/09/2019.
//  Copyright © 2019 100kas d.o.o. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func chatColor() -> UIColor {
        let color = UIColor.darkText
        
        guard let first = self.first?.unicodeScalars.first?.utf16.first,
            let last = self.last?.unicodeScalars.first?.utf16.first
            else {return color}
        
        let idxColor = (Int(first)+Int(last))%19
        return UIColor(named: "nick\(idxColor)") ?? color
    }
    
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)!
        let to = range.upperBound.samePosition(in: utf16)!
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    public func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func sumASCII() -> Int {
        var sum = 0
        for char in self {
            sum += Int(char.asciiValue ?? 0)
        }
        return sum
    }
    
    
    public func isEmojiFlag() -> Bool {
        guard self.count == 4 else { return false } // A flag emoji is composed of two regional indicator symbols
        return self.unicodeScalars.allSatisfy { $0.properties.isEmoji } // Check if all scalars are emoji and regional indicators
    }
    
    
}


extension UnicodeScalar {
    /// Note: This method is part of Swift 5, so you can omit this.
    /// See: https://developer.apple.com/documentation/swift/unicode/scalar
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        0x1F018...0x1F270, // Various asian characters
        0x238C...0x2454, // Misc items
        0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension String {
    // Not needed anymore in swift 4.2 and later, using `.count` will give you the correct result
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    public var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner, !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map { String($0) }.reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
}
