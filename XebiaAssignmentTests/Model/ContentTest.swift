//
//  ContentTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class ContentTest: XCTestCase {
    
    var sut: Content!
    
    override func setUp() {
        super.setUp()
        sut = Content()
    }
    
    func testMapping() {
        //Given:
        let title = "Review: 50 Violins, 50 Computer Chips, a Secular Prayer"
        let abstract = "Tristan Perich’s sublime “Drift Multiply” shared the program at the Cathedral Church of St. John the Divine with Lesley Flanigan’s “Subtonalities.”"
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let thumbnailImageURL = "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg"
        let publishedDate = "2018-05-10T20:00:00-04:00"
        let media = [MediaMetadata(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210)]
        let source = "The New York Times"
        let byline = "By KALY SOTO"
        let mapping = Mapping(json: [
            "title": title,
            "abstract": abstract,
            "url": url,
            "thumbnail_standard": thumbnailImageURL,
            "published_date": publishedDate,
            "multimedias":[
                "media":media,
                "byline":byline,
                "source": source
            ]])
        
        //When:
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.abstract, abstract)
        XCTAssertNotNil(sut.url)
        if let absoluteString = sut.url?.absoluteString {
            XCTAssertEqual(absoluteString, url)
        }
        XCTAssertNotNil(sut.thumbnailImageURL)
        if let absoluteString = sut.thumbnailImageURL?.absoluteString {
            XCTAssertEqual(absoluteString, thumbnailImageURL)
        }
        if let multimedias = sut.multimedias {
            let mediaMetaData = multimedias.last?.metadata
            XCTAssertEqual(multimedias.count, 2)
            XCTAssertEqual(mediaMetaData?[0].url?.absoluteString, url)
            XCTAssertEqual(multimedias[0].type, .unknown)
            XCTAssertEqual(mediaMetaData?[0].format, .mediumThreeByTwo210)
            XCTAssertEqual(mediaMetaData?[1].url?.absoluteString, url)
            XCTAssertEqual(multimedias[1].type, .image)
            XCTAssertEqual(mediaMetaData?[1].format, .normal)
        }
    }
    
}
