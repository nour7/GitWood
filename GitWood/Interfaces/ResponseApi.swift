//
//  ResponseApi.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

enum ResponseType {
    case Trending
    case Invalid
}


enum ResponseStatus:Equatable {
    case Success
    case More
    case Empty
    case Failure(String)
}
