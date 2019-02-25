//
//  MainViewModel.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    
}

protocol UITableViewModel {
    associatedtype type
    var count: Int {get}
    var items:[type] {get set}
    var recentItemsIndexPath: [IndexPath] {get}
    func cellInfoFor(indexPath: IndexPath) -> CellInfoModel
    func rowSelected(at: IndexPath)
}


class MainViewModel<S: StorageProtocol>: UITableViewModel, ViewModel {
    
    typealias repos = TrendingRepo
    private let storage: S
    let apiModel =  API3Model()
    private var _pageNumber = 1
    private let disposeBag = DisposeBag()
    
    init(storage: S) {
        self.storage = storage
    }
    
    var pageNumber: Int {
        get {
            return _pageNumber
        }
        set(page) {
            _pageNumber = page
            //model.parameters[.page] = String(page)
        }
    }
    
    
    var count: Int  {
        get {
            return items.count
        }
    }

    var recentItemsIndexPath: [IndexPath] {
        get {
           return []
        }
    }
    
    var items: [repos] = []
    
    func cellInfoFor(indexPath: IndexPath) -> CellInfoModel {
        
        if items.count < indexPath.item || items.isEmpty {
            fatalError("Items is empty or index is larger than size")
        }
        
        return CellInfoModel(name: items[indexPath.item].name,
                        detailed: items[indexPath.item].description ?? "No description available",
                        avatarUrl: items[indexPath.item].owner.avatarUrl,
                        isFavorited: items[indexPath.item].isFavorited ?? false)
    }
    
    func rowSelected(at: IndexPath) {
        
    }
    
    func loadTrendingRepos(period: RequestPeriod)-> Single<Bool> {
        return Single<Bool>.create { single  in
            self.pageNumber += 1
            do {
                let url =  try self.apiModel.buildRequestUrl(.Trending(period), page: self._pageNumber)
              //check if the request is cached so you don't loose another api call
                
                let req =  URLRequest(url: url)
                URLSession.shared.rx.response(request: req).subscribe(onNext: { res in
                    do {
                        guard try self.apiModel.validate(response: res) else {
                            single(.success(false))
                            return
                        }
                        
                        let repositories =  try self.apiModel.decode(response: res.data, for: .Trending)
                        let trendingRepos = repositories.map{$0 as! MainViewModel<S>.repos}
                        self.items.append(contentsOf: trendingRepos)
                         single(.success(true))
                    }catch {
                        single(.error(error))
                    }
                    
                }, onError: { err in
                    single(.error(err))
                }).disposed(by: self.disposeBag)
                
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
}
