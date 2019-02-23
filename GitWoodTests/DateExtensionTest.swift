//
//  DateExtensionTest.swift
//  GitWoodTests
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import XCTest
@testable import GitWood

class DateExtensionTest: XCTestCase {
    
    var date: Date!
    
    override func setUp() {
        var dateComponents = DateComponents()
        dateComponents.year = 2000
        dateComponents.month = 12
        dateComponents.day = 10
        date = Calendar.current.date(from: dateComponents) // 2000-12-10
    }
    
    override func tearDown() {
    }
    
    func testLastDay() {
        let dateString = date.periodDateFor(.LastDay, specifiedDate: date)
        XCTAssertEqual(dateString, "2000-12-09")
    }
    
    func testLastWeek() {
        let dateString = date.periodDateFor(.LastWeek, specifiedDate: date)
        XCTAssertEqual(dateString, "2000-12-03")
    }
    
    func testLastMonth() {
        let dateString = date.periodDateFor(.LastMonth, specifiedDate: date)
        XCTAssertEqual(dateString, "2000-11-10")
    }
    
}
