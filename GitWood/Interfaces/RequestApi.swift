//
//  RequestApi.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation


//create interface for building approprite request by the user. The app now supprts only trending but in future, multiple different requests could be added
enum RequestType: Hashable {
    case Trending(RequestPeriod)
    case Invalid
    
    var urlPathExt: String {
        switch self {
        case .Trending(let period):
            return "search/repositories?q=created:%3E" + Date().periodDateFor(period)
        case .Invalid:
            return "#^*"
        }
}

}

enum RequestPeriod {
    case LastDay
    case LastWeek
    case LastMonth
}


enum RequestSort: String {
    case Stars = "stars"
    case Forks = "forks"
}

enum RequestOrder: String {
    case Desc = "desc"
    case Asec = "asec"
}
