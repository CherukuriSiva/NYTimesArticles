//
//  DownloadImageServiceTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class DownloadImageServiceTest: XCTestCase {
    
    var sut: DownloadImageService!
    var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        sut = DownloadImageService(session: session)
    }
    
    func testDownloadSuccess() {
        //Given:
        let image = UIImage(named: "test1", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let data = image.pngData()
        
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2019/03/30/opinion/30pawel1web/30pawel1web-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        
        //Then:
        session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDownloadFailureCannotParseDataToImage() {
        //Given:
        let image = UIImage()
        let data = image.pngData()
        
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2019/03/30/opinion/30pawel1web/30pawel1web-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertEqual(error as NSError, APIError.unexpected.error)
            }
            expectation.fulfill()
        }
        
        //Then:
        session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDownloadFailure() {
        //Given:
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2019/03/30/opinion/30pawel1web/30pawel1web-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        //Then:
        session.completion?(nil, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
}
