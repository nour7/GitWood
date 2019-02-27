//
//  ExtMainViewController.swift
//  GitWood
//
//  Created by Nour on 25/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import UIKit

private extension IndexPath {
    var cacheKey: String {
        return String(describing: self)
    }
}

let CellIdentifier = "IdTrendingCell"

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellCachedHeight[indexPath.cacheKey] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellCachedHeight[indexPath.cacheKey] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "Favorite") {
            action, view, completion in
            
            let insertOperation = self.viewModel.insertOrUpdateRepo(at: indexPath)
            
            if !insertOperation {
                //show friendly error msg to user
            } else {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            completion(true)
        }
        favorite.backgroundColor = .blue
        let config = UISwipeActionsConfiguration(actions: [favorite])
        return config
        
    }

    
}

