//
//  BaseServiceApiTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class APITest: XCTestCase {
    
    var sut: API!
    
    func testURLForGetArticlesAPI() {
        sut = .getContents(pageIndex: 0, pageSize: 10)
        XCTAssertTrue(sut.url.absoluteString.hasPrefix("https://api.nytimes.com/svc/mostpopular/v2/emailed/1.json?api-key="))
    }
    
    func testMethodForGetArticlesAPI() {
        sut = .getContents(pageIndex: 0, pageSize: 10)
        XCTAssertEqual(sut.method, .get)
    }
    
}
