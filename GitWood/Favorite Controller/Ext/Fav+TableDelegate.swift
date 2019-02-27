//
//  ExFavoriteViewController.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import UIKit

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as? TrendingTableViewCell
        
        if viewModel.count > indexPath.item {
            let cellModel = viewModel.cellModelFor(indexPath: indexPath)
            cell?.configure(model: cellModel, at: indexPath)
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowSelected(at: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completion in
            
            let removeOperation = self.viewModel.removeFavoriteRepo(at: indexPath)
            
            if !removeOperation {
                //show friendly error msg to user
            } else {
                tableView.reloadData()
            }
            completion(true)
        }
        delete.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [delete])
        return config
        
    }
    
    
}

