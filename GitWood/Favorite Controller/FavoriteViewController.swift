//
//  FavoriteViewController.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : FavoriteViewModel<RealmStorage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FavoriteViewModel(storage: RealmStorage())
        self.tableView.register(UINib.init(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "IdTrendingCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController?.tabBar.isHidden = false
        viewModel.loadFavorites()
        tableView.reloadData()
    }
    
    func rowSelected(at indexPath: IndexPath) {
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        viewController.repo = viewModel.items[indexPath.item]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
