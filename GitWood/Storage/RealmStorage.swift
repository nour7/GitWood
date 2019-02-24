//
//  RealStorage.swift
//  GitWood
//
//  Created by Nour on 24/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRepoModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var response: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class RealmStorage:StorageProtocol {
    typealias output = Bool
    typealias queryInput = QueryType
    
    func insertOrUpdate(type: StorageRecords, records: [RepoModel]) -> output {
        
       
        return true
    }
    
    func remove(type: StorageRecords, id: Int) -> output {
        
        return true
    }
    
    func query(type: StorageRecords, input: queryInput) -> [RepoModel]? {
       
        return nil
       
    }
}
