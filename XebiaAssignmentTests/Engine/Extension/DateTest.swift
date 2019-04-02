//
//  DateTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class DateTest: XCTestCase {
    var sut: Date!
    
    func testDateString() {
        //Given:
        var component = DateComponents()
        component.year = 2018
        component.month = 5
        component.day = 12
        sut = Calendar.current.date(from: component)
        
        //When:
        let dateString = sut.dateString
        
        //Then:
        XCTAssertEqual(dateString, "12/05/2018")
    }
}
