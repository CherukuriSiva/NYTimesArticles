//
//  MediaMetadata.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

enum MediaType: String {
    case image = "image"
    case unknown = "unknown"
}

enum MediaFormat: String {
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case unknown = "unknown"
}

struct MediaMetadata {
    var url: URL?
    var format: MediaFormat = .unknown
}

// MARK: - Mappable

extension MediaMetadata: Mappable {
    mutating func mapping(map: Mapping) {
        url = map["url"]
        format = map["format"] ?? .unknown
    }
}

// MARK: - Equatable

extension MediaMetadata: Equatable {
    static func == (lhs: MediaMetadata, rhs: MediaMetadata) -> Bool {
        return lhs.format == rhs.format
            && lhs.url == rhs.url
    }
}
