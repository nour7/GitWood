//
//  DetailedViewModelTests.swift
//  GitWoodTests
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest

@testable import GitWood

class DetailedViewModelTests: XCTestCase {
    var viewModel: DetailedViewModel!
    
    override func setUp() {
        let repo = TrendingRepo(id: 0, isFavorited: false, owner: OwnerModel(login: "ok", avatarUrl: URL(string: "https://www.google.com/")!), name:"test", description: "unit testing", stars: 200, language: nil, forks: 300, creationDate: "21-10-2018", repoPage: URL(string: "https://www.google.com/")!)
        
        viewModel = DetailedViewModel(model: repo)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItems() {
        XCTAssertEqual(viewModel.items.count, 3)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
