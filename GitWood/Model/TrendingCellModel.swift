//
//  CellInfo.swift
//  GitWood
//
//  Created by Nour on 25/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

struct TrendingCellModel {
    let id: Int
    let name: String
    let detailed: String
    let forks: Int
    let stars: Int
    let avatarUrl: URL
    let isFavorited: Bool
}
