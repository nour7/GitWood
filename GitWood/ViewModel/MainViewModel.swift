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

protocol ViewModel {}

protocol UITableViewModel {
    associatedtype type
    var count: Int {get}
    var items:[type] {get set}
    var moreItemsIndexPath: [IndexPath] {get}
    func cellModelFor(indexPath: IndexPath) -> TrendingCellModel
    func rowSelected(at: IndexPath)
}

class MainViewModel<S: StorageProtocol>: UITableViewModel, ViewModel {
    
    typealias repos = TrendingRepo
    private let storage: S
    let apiModel =  API3Model()
    private var _pageNumber = 0
    private let disposeBag = DisposeBag()
    private var lastIndexPath = IndexPath(item: 0, section: 0)
   
    
    init(storage: S) {
        self.storage = storage
    }
    
    var pageNumber: Int {
        get {
            return _pageNumber
        }
        set(page) {
            _pageNumber = page
        }
    }
    
    
    var count: Int  {
        get {
            return items.count
        }
    }

    var moreItemsIndexPath: [IndexPath] {
        get {
            let indexPaths =  items.enumerated()
                .filter{$0.offset > lastIndexPath.item}
                .map {IndexPath(item: $0.offset, section: 0)}
            lastIndexPath.item = items.count - 1
            return indexPaths
            }
    }
    
    var items: [repos] = []
    
    func cellModelFor(indexPath: IndexPath) -> TrendingCellModel {
        
        if items.count < indexPath.item || items.isEmpty {
            fatalError("Items is empty or index is larger than size")
        }
        
        return TrendingCellModel(name: items[indexPath.item].name,
                        detailed: items[indexPath.item].description ?? "No description available",
                        forks:items[indexPath.item].forks,
                        avatarUrl: items[indexPath.item].owner.avatarUrl,
                        isFavorited: items[indexPath.item].isFavorited ?? false)
    }
    
    func rowSelected(at: IndexPath) {
        
    }
    
    func loadTrendingRepos(period: RequestPeriod)-> Single<ResponseStatus> {
        return Single<ResponseStatus>.create { single  in
            self.pageNumber += 1
            do {
                let url =  try self.apiModel.buildRequestUrl(.Trending(period), page: self._pageNumber)
              
                //check if the request is cached so you don't use another api call
                
                let req =  URLRequest(url: url)
                URLSession.shared.rx.response(request: req).subscribe(onNext: { res in
                    do {
                        guard try self.apiModel.validate(response: res) else {
                            single(.success(.Failure("HTTP response could not be validated")))
                            return
                        }
                       
                        let repositories =  try self.apiModel.decode(response: res.data, for: .Trending)
                        let trendingRepos = repositories.map{$0 as! MainViewModel<S>.repos}
                        if self.items.isEmpty {
                            self.items.append(contentsOf: trendingRepos)
                            single(.success(.Success))
                        } else {
                            self.items.append(contentsOf: trendingRepos)
                            single(.success(.More))
                        }
                       
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
