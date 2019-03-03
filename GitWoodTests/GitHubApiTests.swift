//
//  GitApiTests.swift
//  GitWoodTests
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
@testable import GitWood

class GitHubApiTests: XCTestCase {

    var model: APIInterfaceProtocol!
    
    override func setUp() {
       model = APIV3Model()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBuildRequestUrlNotFailing() {
       
        XCTAssertNoThrow(try model.buildRequestUrl(.Trending(.LastDay), page: 1))
    }
    
    func testBuildRequestLastDayUrl() {
        
        let baseUrl = "https://api.github.com/search/repositories?q=created:%3E"
        let dateString = Date().periodDateFor(.LastDay)
        let urlString = URL(string: baseUrl + dateString + "&sort=stars&order=desc&page=1")
        
        XCTAssertEqual(try model.buildRequestUrl(.Trending(.LastDay), page: 1), urlString)
        
    }
    
    func testBuildRequestLastWeekUrl() {
        
        let baseUrl = "https://api.github.com/search/repositories?q=created:%3E"
        let dateString = Date().periodDateFor(.LastWeek)
        let urlString = URL(string: baseUrl + dateString + "&sort=stars&order=desc&page=1")
        
        XCTAssertEqual(try model.buildRequestUrl(.Trending(.LastWeek), page: 1), urlString)
        
    }
    
    func testBuildRequestLastMonthUrl() {
        
        let baseUrl = "https://api.github.com/search/repositories?q=created:%3E"
        let dateString = Date().periodDateFor(.LastMonth)
        let urlString = URL(string: baseUrl + dateString + "&sort=stars&order=desc&page=1")
        
        XCTAssertEqual(try model.buildRequestUrl(.Trending(.LastMonth), page: 1), urlString)
        
    }
    
    func testDecodeTrending() {
        let file = Bundle.main.url(forResource: "mock", withExtension: "json")
        let data = try! Data(contentsOf: file!)
        
        XCTAssertNoThrow(try model.decode(response: data, for: .Trending))
        
        let results = try! model.decode(response: data, for: .Trending) as? [TrendingRepo]
        
        XCTAssertNotNil(results)
        XCTAssertEqual(results?.count, 30)
        XCTAssertEqual(results!.first!.id, 43059609)

    }
    
    func testValidateResponse() {
        let httpResponse = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 300, httpVersion: nil, headerFields: nil)!
        
        XCTAssertNoThrow(try model.validate(response: (httpResponse, Data())))
        
         XCTAssertEqual(try model.validate(response: (httpResponse, Data())), false)
        
        let notFoundResponse = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        let file = Bundle.main.url(forResource: "mock", withExtension: "json")
        let data = try! Data(contentsOf: file!)
        
        XCTAssertThrowsError(try model.validate(response: (notFoundResponse, data)))

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}

