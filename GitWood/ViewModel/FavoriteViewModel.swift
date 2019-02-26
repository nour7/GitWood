//
//  FavoriteViewModel.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

class FavoriteViewModel<S: StorageProtocol>: UITableViewModelProtocol, ViewModel {
    typealias repos = TrendingRepo
    typealias cell = TrendingCellModel
    
    let storage: S
    var items: [repos] = []
    
    init(storage: S) {
        self.storage = storage
    }
    
    var count: Int  {
        get {
            return items.count
        }
    }
    
    func loadFavorites() {
        
        if let repositories = storage.query(type: .Favorite, input: .AllFavorite ) as? [repos] {
           items.append(contentsOf: repositories)
        } else {
            //show error msg to use
        }

    }
    
    func cellModelFor(indexPath: IndexPath) -> cell {
        
        if items.count < indexPath.item || items.isEmpty {
            fatalError("Items is empty or index is larger than size")
        }
        
        return TrendingCellModel(id: items[indexPath.item].id, name: items[indexPath.item].name,
                                 detailed: items[indexPath.item].description ?? "No description available",
                                 forks:items[indexPath.item].forks,
                                 stars:items[indexPath.item].stars,
                                 avatarUrl: items[indexPath.item].owner.avatarUrl,
                                 isFavorited: items[indexPath.item].isFavorited ?? false)
    }
    
    func removeFavoriteRepo(at indexPath: IndexPath) -> Bool {
        
        let removeOperation = storage.remove(type: .Favorite, id: items[indexPath.item].id)
        
        if !removeOperation {
            return false
        } else {
            items.remove(at: indexPath.item)
            return true
        }
        
    }

    
}
