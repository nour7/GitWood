//
//  MainModel.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

struct TrendingRepo: Decodable {
    let id:Int
    let owner:String
    let name:String
    let description: String
    let avatarUrl: URL
    let stars: Int
    let language: String
    let forks: Int
    let creationDate: Date
    let repoPage: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner = "login"
        case name = "name"
        case description
        case avatarUrl = "avatar_url"
        case stars = "stargazers_count"
        case language
        case forks
        case creationDate = "created_at"
        case repoPage = "html_url"
        
    }
}
