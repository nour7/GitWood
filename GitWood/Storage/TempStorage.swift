//
//  TempStorage.swift
//  GitWood
//
//  Created by Nour on 24/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

class TempStorage:StorageProtocol {
   
    var cache:[Int: RepoModel] = [:]
    
    func insertOrUpdate(type: StorageRecords, records: [RepoModel]) -> Bool {
        for record in records {
            if cache.keys.contains(record.id) {
                cache.updateValue(record, forKey: record.id)
            } else {
                cache[record.id] = record
            }
        }
        
        return true
    }
    
    func remove(type: StorageRecords, id: Int) -> Bool {
        
        if cache.keys.contains(id) {
            if cache.removeValue(forKey: id) == nil {
                return false
            }
        }
        
        return true
    }
    
    func query(type: StorageRecords, input: QueryType) -> [RepoModel]? {
        
        switch input {
        case .AllFavorite:
            return Array(cache.values)
        case .Record(let id):
            guard let record = cache[id] else {return nil}
            return [record]
        }
    }
}
