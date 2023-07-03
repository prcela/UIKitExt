//
//  IntExt.swift
//  Yamb
//
//  Created by Kresimir Prcela on 05/02/2020.
//  Copyright © 2020 100kas d.o.o. All rights reserved.
//

import Foundation

extension SignedInteger {
    public func shortedString() -> String? {
        if self >= 1000000 {
            if self % 1000000 == 0 {
                let mil = self / 1000000
                return "\(mil)M"
            }
            if self % 100000 == 0 {
                let mil = self / 1000000
                let ostStoTis = self % 1000000
                let stoTis = ostStoTis / 100000
                return "\(mil),\(stoTis)M"
            }
        }
        if self >= 1000 {
            if self % 1000 == 0 {
                let tisucice = self / 1000
                return "\(tisucice)k"
            }
            if self % 100 == 0 {
                let tisucice = self / 1000
                let ostatakStotice = self % 1000
                let stotice = ostatakStotice / 100
                return "\(tisucice),\(stotice)k"
            }
        }
        return nil
    }
}

