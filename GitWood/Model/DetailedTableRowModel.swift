//
//  DetailedTableRowModel.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation


enum DetailedTableRow: String {
    case Language = "language"
    case Forks = "forks"
    case Stars = "stargazers_count"
    case CreationDate = "created_at"
    
    var iconName: String {
        switch self {
        case .Language:
            return "computer"
        case .Forks:
            return "forks"
        case .Stars:
            return "star"
        case .CreationDate:
            return "calendar"
        }
    }
    
    static var raws:[String] = [Language.rawValue, Forks.rawValue, Stars.rawValue, CreationDate.rawValue]
    
     static var all:[DetailedTableRow] = [Language, Forks, Stars, CreationDate]
}

struct DetailedTableRowModel {
    let icon: String
    let text: String
}
