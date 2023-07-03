//
//  NumberFormatterExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 11/08/2019.
//  Copyright © 2019 100kas d.o.o. All rights reserved.
//

import Foundation
import StoreKit

extension NumberFormatter {
    public class func price(product: SKProduct) -> NumberFormatter {
        let nf = NumberFormatter()
        nf.locale = product.priceLocale
        nf.numberStyle = .currency
        return nf
    }

    fileprivate static let grouped: NumberFormatter = {
        let gnf = NumberFormatter()
        gnf.groupingSize = 3
        gnf.groupingSeparator = ","
        gnf.usesGroupingSeparator = true
        return gnf
    }()
    
    fileprivate static let stars: NumberFormatter = {
        let sf = NumberFormatter()
        sf.decimalSeparator = "."
        sf.maximumFractionDigits = 1
        sf.minimumFractionDigits = 1
        sf.minimumIntegerDigits = 1
        return sf
    }()
}

extension Int {
    public func longFormatted() -> String {
        return NumberFormatter.grouped.string(from: NSNumber(value: self))!
    }
}
