//
//  DetailedViewController.swift
//  GitWood
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    var viewModel : DetailedViewModel!
    var repo: TrendingRepo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailedViewModel(model: repo)
        descriptionLabel.text = repo?.description
        navigationTitle.title = repo?.name
        self.navigationItem.title = repo?.name
        tableView.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func openRepoURL(_ sender: UIButton) {
        if let repoUrl = repo?.repoPage {
            UIApplication.shared.open(repoUrl)
        }
    }
    
}
