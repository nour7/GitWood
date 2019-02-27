//
//  IntExt.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

extension Int {
    var numberFormatted: String {
        
        if self >= 100_000 && self < 100_000_000 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        else if (self >= 100_000_000) {
             return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
           
        }
       
        return String(format: "%d", locale: Locale.current,self)
    }
}
