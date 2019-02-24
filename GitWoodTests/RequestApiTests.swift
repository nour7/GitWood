//
//  RequestApiTests.swift
//  GitWoodTests
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
@testable import GitWood

class RequestApiTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    //make sure raw value are not modified by mistake
    func testEnumRawValue() {
        XCTAssertEqual(RequestOrder.Desc.rawValue, "desc")
        XCTAssertEqual(RequestOrder.Asec.rawValue, "asec")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

