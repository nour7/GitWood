//
//  RealmStorageTest.swift
//  GitWoodTests
//
//  Created by Nour on 26/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
import RealmSwift

@testable import GitWood


class RealmStorageTest: XCTestCase {
    var realmStorage: RealmStorage!
    override func setUp() {
      
       Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
       realmStorage = RealmStorage()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertOrUpdate() {
       
            let repo = TrendingRepo(id: 0, isFavorited: false, owner: OwnerModel(login: "ok", avatarUrl: URL(string: "https://www.google.com/")!), name:"test", description: "unit testing", stars: 200, language: nil, forks: 300, creationDate: "21-10-2018", repoPage: URL(string: "https://www.google.com/")!)
           
       XCTAssertTrue(realmStorage.insertOrUpdate(type: .Favorite, records: [repo]))
    }
    
    func testDeleteAndQuery() {
        
        let repo = TrendingRepo(id: 0, isFavorited: false, owner: OwnerModel(login: "ok", avatarUrl: URL(string: "https://www.google.com/")!), name:"test", description: "unit testing", stars: 200, language: nil, forks: 300, creationDate: "21-10-2018", repoPage: URL(string: "https://www.google.com/")!)
        
        let _ = realmStorage.insertOrUpdate(type: .Favorite, records: [repo])
        
        var allFavorite = realmStorage.query(type: .Favorite, input: .AllFavorite)
        
        XCTAssertNotNil(allFavorite)
        XCTAssertEqual(allFavorite!.count, 1)
        
        XCTAssertTrue(realmStorage.remove(type: .Favorite, id: 0))
        
        allFavorite = realmStorage.query(type: .Favorite, input: .AllFavorite)
        XCTAssertNotNil(allFavorite)
        XCTAssertEqual(allFavorite!.count, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
