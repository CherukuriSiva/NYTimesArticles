//
//  URLSessionMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation
@testable import XebiaAssignment

final class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {
        //Overriding method
    }
}

class URLSessionMock: URLSessionProtocol {
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completion = completionHandler
        return URLSessionDataTaskMock()
    }
}
