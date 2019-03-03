//
//  MainViewModelTests.swift
//  GitWoodTests
//
//  Created by Nour on 25/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import GitWood


class MainViewModelTests: XCTestCase {
    var mainViewModel: MainViewModel<TempStorage>!
     var scheduler: ConcurrentDispatchQueueScheduler!
    
    override func setUp() {
        mainViewModel = MainViewModel(storage: TempStorage(), apiVersion: ApiVersion.v3)
        scheduler = ConcurrentDispatchQueueScheduler.init(qos: .default)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMoreItemsIndexPath(){
        XCTAssertEqual(mainViewModel.moreItemsIndexPath, [])
        let file = Bundle.main.url(forResource: "mock", withExtension: "json")
        let data = try! Data(contentsOf: file!)
        
        mainViewModel.items = try! mainViewModel.apiModel.decode(response: data, for: .Trending) as? [TrendingRepo] ?? []
        
         XCTAssertEqual(mainViewModel.moreItemsIndexPath.first!, IndexPath(item: 0, section: 0))
        
        
          let moreItems = try! mainViewModel.apiModel.decode(response: data, for: .Trending) as? [TrendingRepo] ?? []
        
          mainViewModel.items.append(contentsOf: moreItems)
        
        XCTAssertEqual(mainViewModel.moreItemsIndexPath.first!, IndexPath(item: 30, section: 0))
        
    }
    
    func testCellModelFor() {
        let file = Bundle.main.url(forResource: "mock", withExtension: "json")
        let data = try! Data(contentsOf: file!)
        
        mainViewModel.items = try! mainViewModel.apiModel.decode(response: data, for: .Trending) as? [TrendingRepo] ?? []

        let testCellInfo = TrendingCellModel(id: 0, name: "ASPNETSelfCreatedTokenAuthExample", detailed: "Example of how to protect an ASP.NET Core (1.0.1) Web API using simple self-created JWT bearer tokens.", forks: 200, stars: 20, avatarUrl: URL(string: "https://avatars3.githubusercontent.com/u/7505593?v=4")!, isFavorited: false)
        
        let cell = mainViewModel.cellModelFor(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.name, testCellInfo.name)
        XCTAssertEqual(cell.detailed, testCellInfo.detailed)
        XCTAssertEqual(cell.avatarUrl, testCellInfo.avatarUrl)
         XCTAssertEqual(cell.isFavorited, testCellInfo.isFavorited)
    }

    func testLoadTrendingRepos() {
        
       let single = mainViewModel.loadTrendingRepos(period: .LastMonth).subscribeOn(scheduler)
         let response = single.toBlocking(timeout: 3.0).materialize()
        
        switch response {
        case .completed(elements: let repos):
             XCTAssertEqual(mainViewModel.count, 30)
              XCTAssertEqual(repos.first!, ResponseStatus.Success)
            break
        case .failed(elements: _, error: _):
            break
        }
        
        
        mainViewModel.pageNumber = 1000000 //to make it fails
        
        let singleError = mainViewModel.loadTrendingRepos(period: .LastDay).subscribeOn(scheduler)
        let responseError = singleError.toBlocking(timeout: 3.0).materialize()

        switch responseError {
        case .completed(elements:_):
            break
        case .failed(elements: let repos, error: let err):
            XCTAssertNil(repos.first)
            XCTAssertEqual(err.localizedDescription, ApiError.ErrorHttpCode("").localizedDescription)
            break
    }
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
