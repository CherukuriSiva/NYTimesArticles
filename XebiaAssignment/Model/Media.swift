//
//  Media.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

struct Media {
    var metadata: [MediaMetadata]?
    var type: MediaType = .unknown
    var caption: String?
    var copyright: String?
}

// MARK: - Mappable

extension Media: Mappable {
    mutating func mapping(map: Mapping) {
        metadata = map["media-metadata"]
        type = map["type"] ?? .unknown
        caption = map["caption"]
        copyright = map["copyright"]
    }
}

// MARK: - Equatable

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return
            lhs.metadata == rhs.metadata
            && lhs.type == rhs.type
            && lhs.caption == rhs.caption
            && lhs.copyright == rhs.copyright
    }
}
