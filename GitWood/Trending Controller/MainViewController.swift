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
    
    var viewModel : MainViewModel<RealmStorage>!
    private var disposeBag = DisposeBag()
    private var stopPrefetching = true
    private let prefetchOffset = 10 // this number has to be dynamic cuase some call may retrun less than 10 items
    var cellCachedHeight: [String: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel(storage: RealmStorage(), apiVersion: ApiVersion.v3)
        self.tableView.register(UINib.init(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "IdTrendingCell")
        
        loadTrendingReposAsync()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        viewModel.reloadSavedFavorites()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func loadTrendingReposAsync(period: RequestPeriod = .LastDay) {
        
        viewModel.loadTrendingRepos(period: period).observeOn(MainScheduler.instance).subscribe(onSuccess: { status in
            switch status {
            case .Success:
                self.tableView.reloadData()
                self.stopPrefetching = false
            case .More:
                self.tableView.insertRows(at: self.viewModel.moreItemsIndexPath, with: .automatic)
                //self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                self.stopPrefetching = false
            case .Empty:
                //show nice notification message to the user
                 self.stopPrefetching = true
                break
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
                loadTrendingReposAsync(period: .LastDay)
            }
        }
    }
    
    
    func rowSelected(at indexPath: IndexPath) {
        
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        viewController.repo = viewModel.items[indexPath.item]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func onSegmentValueChanged(_ sender: UISegmentedControl) {
        
        viewModel.reset()
        tableView.reloadData()
        
        switch sender.selectedSegmentIndex {
        case 0:
            loadTrendingReposAsync(period: .LastDay)
            break
        case 1:
             loadTrendingReposAsync(period: .LastWeek)
            break
        case 2:
             loadTrendingReposAsync(period: .LastMonth)
            break
        default:
             loadTrendingReposAsync(period: .LastDay)
        }
    }
}

