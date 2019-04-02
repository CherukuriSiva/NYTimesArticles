//
//  MappableObjectBMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

@testable import XebiaAssignment

struct MappableObjectBMock: Mappable {
    var object: MappableObjectAMock?
    var array: [MappableObjectAMock]?
    
    mutating func mapping(map: Mapping) {
        object = map["object"]
        array = map["array"]
    }
}
