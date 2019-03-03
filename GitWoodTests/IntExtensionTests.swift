//
//  IntExtensionTests.swift
//  GitWoodTests
//
//  Created by Nour on 03/03/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
@testable import GitWood

class IntExtensionTest: XCTestCase {

    override func setUp() {
      
    }
    
    override func tearDown() {
    }
    
    func testNumberToK() {
        var num = 150_500
        XCTAssertEqual(num.numberFormatted, "150.5K")
        
        num = 100_000
        XCTAssertEqual(num.numberFormatted, "100K")
        
        num = 9999
        XCTAssertEqual(num.numberFormatted, "10K")
      
    }
    
    func testNumberToM() {
        var num = 110_000_000
        XCTAssertEqual(num.numberFormatted, "110M")
        
        num = 200_200_000
        XCTAssertEqual(num.numberFormatted, "200.2M")
    }
    
    func testNumber() {
        var num = 110
        XCTAssertEqual(num.numberFormatted, "110")
        
        num = 1
        XCTAssertEqual(num.numberFormatted, "1")
    }
    
}
