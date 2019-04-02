//
//  ContentServiceApiTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class ContentServiceApiTest: XCTestCase {
    
    var sut: ContentServiceApi!
    var request: RequestServiceMock<ContentResponse>!
    
    override func setUp() {
        super.setUp()
        request = RequestServiceMock()
        sut = ContentServiceApi(request: request)
    }
    
    func testRequestSuccess() {
        //Given:
        let successExpectation = expectation(description: #function + "success")
        let failureExpectation = expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedContent = Content()
        let contentResponse = ContentResponse(status: .ok, contents: [expectedContent])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if let content = value.first {
                    XCTAssertEqual(expectedContent, content)
                }
                successExpectation.fulfill()
            case .failure:
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.success(contentResponse))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestFailureCannotReachServer() {
        //Given:
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let contentResponse = ContentResponse(status: .unknown, contents: [])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(APIError.serverError.error, error as NSError)
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.success(contentResponse))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestFailure() {
        //Given:
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.failure(expectedError))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}
