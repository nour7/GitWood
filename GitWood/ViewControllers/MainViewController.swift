//
//  ViewController.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, UITableViewDataSourcePrefetching {
   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : MainViewModel<TempStorage>!
    private var disposeBag = DisposeBag()
    private var stopPrefetching = true
    private let prefetchOffset = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(storage: TempStorage())
       self.tableView.register(UINib.init(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "IdTrendingCell")
        
        loadTrendingReposAsync()
    }
    
    
    func loadTrendingReposAsync() {
        viewModel.loadTrendingRepos(period: .LastWeek).observeOn(MainScheduler.instance).subscribe(onSuccess: { status in
                switch status {
                    case .Success:
                        self.tableView.reloadData()
                        self.stopPrefetching = false
                    case .More:
                        self.tableView.insertRows(at: self.viewModel.moreItemsIndexPath, with: .automatic)
                        self.stopPrefetching = false
                    case .Failure(let errorMsg):
                        self.stopPrefetching = true
                        self.tableView.reloadData()
                }
            
        }, onError: { err in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !stopPrefetching {
            if indexPaths.last!.item >= (viewModel.count - prefetchOffset) {
                stopPrefetching = true
                //loadTrendingReposAsync()
            }
        }
    }
    
}

