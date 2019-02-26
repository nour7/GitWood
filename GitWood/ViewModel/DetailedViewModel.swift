//
//  DetailedViewModel.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation



class DetailedViewModel: ViewModel {
    
    private var repoModel: TrendingRepo? = nil
    var items: [DetailedTableRowModel] = []
    
    init(model: TrendingRepo?) {
        self.repoModel = model
        if model != nil {
            items = self.encodeModel().map(self.serialize).compactMap{$0}
        }
    }
    
    var count: Int  {
        get {
            return items.count
        }
    }
    
    private func encodeModel() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        do {
            let data = try JSONEncoder().encode(self.repoModel)
            dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
            
        }catch {
            return [:]
        }
        
        return dictionary
    }
    
    private func serialize(item: (key: String, value: Any)) -> DetailedTableRowModel? {
       
        if  !DetailedTableRow.raws.contains(item.key) {
            return nil
        }
       
        var value:String = ""
        
        if item.value is Int {
            value = (item.value as! Int).numberFormatted
        } else {
            value = item.value as! String
        }
        
        for row in DetailedTableRow.all {
            if item.key == row.rawValue {
                return DetailedTableRowModel(icon: row.iconName, text: value)
            }
        }
        
         return nil

    }
    
    
    
}
