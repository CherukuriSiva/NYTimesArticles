//
//  HomeViewControllerTest.swift
//  XebiaAssignmentUITests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest

class HomeViewControllerTest: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testListOfContents() {
        
        sleep(5) //Waiting for network
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.exists)
        
        let image = cell.children(matching: .other).element.children(matching: .other).element
        image.swipeUp()
    }

}
