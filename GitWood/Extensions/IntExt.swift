//
//  IntExt.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

extension Int {
    var forksFormatted: String {
       // convert number to K, M such as 21k
        return String(format: "%d", locale: Locale.current,self)
    }
}
