//
//  ContentServiceApiMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

@testable import XebiaAssignment

final class ContentServiceApiMock: ContentServiceApiProtocol {
    
    var pageIndex: UInt = 0
    var pageSize: UInt = 0
    var completion: ((Response<[Content]>) -> Void)?
 
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void) {
        self.pageSize = pageSize
        self.pageIndex = pageIndex
        self.completion = completion
    }
    
}
