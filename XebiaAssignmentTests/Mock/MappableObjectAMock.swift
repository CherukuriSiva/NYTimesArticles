//
//  MappableObjectAMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

@testable import XebiaAssignment

struct MappableObjectAMock: Mappable {
    var string: String?
    
    mutating func mapping(map: Mapping) {
        string = map["string"]
    }
}
