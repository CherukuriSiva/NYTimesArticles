//
//  ArticlesViewControllerTest.swift
//  XebiaAssignmentUITests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest

class ArticlesViewControllerTest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testGoToArticleDetail() {
        sleep(5) //Waiting for network
        app.collectionViews.children(matching: .cell).element(boundBy: 0).tap()
    }

}
