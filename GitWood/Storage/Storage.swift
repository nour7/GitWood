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
    func insertOrUpdate(type: StorageRecords, records: [RepoModel]) -> Bool
    func remove(type: StorageRecords, id: Int) -> Bool
    func query(type: StorageRecords, input: QueryType) -> [RepoModel]?
}


