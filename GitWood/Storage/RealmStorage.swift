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
    @objc dynamic var repoModel: Data? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class RealmStorage:StorageProtocol {
    
    func insertOrUpdate(type: StorageRecords, records: [RepoModel]) -> Bool {
        
        switch type {
            case .Favorite:
                    return insertFavorite(records: records)
            }
        
    }
    
    func remove(type: StorageRecords, id: Int) -> Bool {
         if let realm = try? Realm() {
            guard let repo = realm.object(ofType: RealmRepoModel.self, forPrimaryKey:id) else {
                return false
            }
            
            do {
                try realm.write {
                    realm.delete(repo)
                }
            }catch {
                return false
            }
        }
        return true
    }
    
    func query(type: StorageRecords, input: QueryType) -> [RepoModel]? {
       
        switch input {
        case .AllFavorite:
            return loadAllFavorites()
        default:
            return nil
        }
    }
    
    func insertFavorite(records: [RepoModel]) -> Bool {
        if let realm = try? Realm() {
            
            for record in records {
                guard let _ = realm.object(ofType: RealmRepoModel.self, forPrimaryKey: record.id) else {
                    
                    do {
                        let data = try JSONEncoder().encode(record as! TrendingRepo)
                        let newRepo = RealmRepoModel()
                        newRepo.id = record.id
                        newRepo.repoModel = data
                        
                        try? realm.write {
                            realm.add(newRepo)
                        }
                        return true
                    }catch {
                        return false
                    }
                }
            }
        }
        
        return false
    }
    
    func loadAllFavorites() -> [RepoModel] {
        
        var repos: [TrendingRepo] = []
        
        if let realm = try? Realm() {
            let allRepos = realm.objects(RealmRepoModel.self)
            for repo in allRepos {
                if let data = repo.repoModel {
                    if let decodedModel = try?  JSONDecoder().decode(TrendingRepo.self, from: data) {
                        repos.append(decodedModel)
                    }
                }
            }
        }
        
        return repos
    }

}
