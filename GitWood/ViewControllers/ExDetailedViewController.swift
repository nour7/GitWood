//
//  ExDetailedViewController.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import UIKit


let CellDetailedIdentifier = "IdDetailedCell"

extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellDetailedIdentifier, for: indexPath)
        
        if viewModel.count > indexPath.item {
            let cellModel = viewModel.items[indexPath.item]
            cell.imageView?.image = UIImage(named: cellModel.icon)
            cell.textLabel?.text = cellModel.text
        }
        
        
        return cell
    }
    
    
}

