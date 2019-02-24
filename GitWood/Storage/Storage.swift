//
//  Storage.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//


import Foundation

enum StorageType {
    case Temp
    case Database
}

enum StorageRecords {
    case Favorite
}

enum QueryType {
    case AllFavorite
    case Record(Int)
}

protocol StorageProtocol {
    associatedtype output
    associatedtype queryInput
    
    func insertOrUpdate(type: StorageRecords, records: [RepoModel]) -> output
    func remove(type: StorageRecords, id: Int) -> output
    func query(type: StorageRecords, input: queryInput) -> [RepoModel]?
}
