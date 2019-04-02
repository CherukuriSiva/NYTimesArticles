//
//  Article.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

public struct Content {
    var title: String?
    var abstract: String?
    var url: URL?
    var thumbnailImageURL: URL?
    var date: Date?
    var multimedias: [Media]?
    var byline: String?
    var source: String?
}

// MARK: - Mappable

extension Content: Mappable {
    mutating func mapping(map: Mapping) {
        title = map["title"]
        abstract = map["abstract"]
        url = map["url"]
        thumbnailImageURL = map["thumbnail_standard"]
        date = map["published_date", .iso8601CombinedDateAndTime]
        multimedias = map["media"]
        byline = map["byline"]
        source = map["source"]
    }
}

// MARK: - Equatable

extension Content: Equatable {
    public static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.title == rhs.title
        && lhs.abstract == rhs.abstract
        && lhs.url == rhs.url
        && lhs.thumbnailImageURL == rhs.thumbnailImageURL
        && lhs.date == rhs.date
        && lhs.multimedias == rhs.multimedias
        && lhs.byline == rhs.byline
        && lhs.source == rhs.source
    }
}
