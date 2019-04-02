//
//  ContentResponse.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

struct ContentResponse {
    var status: ResponseStatus = .unknown
    var contents: [Content] = []
}

// MARK: - Mappable

extension ContentResponse: Mappable {
    mutating func mapping(map: Mapping) {
        status = map["status"] ?? .unknown
        contents = map["results"] ?? []
    }
}
