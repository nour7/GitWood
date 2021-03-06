//
//  MainModel.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

struct TrendingResponse: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [TrendingRepo]
}

struct TrendingRepo: RepoModel, Codable {
    var id: Int
    var isFavorited: Bool? = nil
    let owner:OwnerModel
    let name:String
    let description: String?
    let stars: Int
    let language: String?
    let forks: Int
    let creationDate: String
    let repoPage: URL
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name = "name"
        case description
        case stars = "stargazers_count"
        case language
        case forks
        case creationDate = "created_at"
        case repoPage = "html_url"
        
    }
}

struct OwnerModel: Codable {
    let login: String
    let avatarUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
}
