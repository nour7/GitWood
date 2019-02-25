//
//  RepoTableViewDelegate.swift
//  GitWood
//
//  Created by Nour on 25/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class RepoTableViewDelegate<model: UITableViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let CellIdentifier = "RepoCell"
    private var viewModel: model!
    
    init(viewModel: inout model) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
         let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
                if viewModel.count > indexPath.item {
                    let cellInfo = viewModel.cellInfoFor(indexPath: indexPath)
                    cell.textLabel?.text = cellInfo.name
                    cell.detailTextLabel?.text = cellInfo.detailed
                    cell.imageView?.kf.setImage(with: cellInfo.avatarUrl)
                }
        
        
        return cell
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelected(at: indexPath)
    }
    
}
