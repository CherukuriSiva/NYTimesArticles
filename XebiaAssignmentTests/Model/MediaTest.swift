//
//  MediaTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class MediaTest: XCTestCase {
    
    var sut: Media!
    
    override func setUp() {
        super.setUp()
        sut = Media()
    }
    
    func testMapping() {
        
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "type": "image",
            "caption": caption,
            "copyright": copyright,
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        if let metadata = sut.metadata {
            //Then:
            XCTAssertEqual(metadata[0].url?.absoluteString, url)
            XCTAssertEqual(sut.type, .image)
            XCTAssertEqual(metadata[0].format, .standardThumbnail)
            XCTAssertEqual(sut.caption, caption)
            XCTAssertEqual(sut.copyright, copyright)
        }
    }
    
    func testMappingTypeShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "type": "image",
            "caption": caption,
            "copyright": copyright,
        ]

        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        if let metadata = sut.metadata {
            //Then:
            XCTAssertEqual(metadata[0].url?.absoluteString, url)
            XCTAssertEqual(sut.type, .image)
            XCTAssertEqual(metadata[0].format, .standardThumbnail)
            XCTAssertEqual(sut.caption, caption)
            XCTAssertEqual(sut.copyright, copyright)
        }
    }
    
    func testMappingFormatShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "type": "image",
            "caption": caption,
            "copyright": copyright,
        ]

        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        if let metadata = sut.metadata {
            //Then:
            XCTAssertEqual(metadata[0].url?.absoluteString, url)
            XCTAssertEqual(sut.type, .image)
            XCTAssertEqual(metadata[0].format, .standardThumbnail)
            XCTAssertEqual(sut.caption, caption)
            XCTAssertEqual(sut.copyright, copyright)
        }
    }
    
    func testEqualShouldReturnTrue() {
        let metadata = [MediaMetadata(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210)]
        sut = Media(metadata: metadata, type: .image, caption: "caption", copyright: "copyright")
        let multimediaMetadata = Media(metadata: metadata, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertEqual(sut, multimediaMetadata)
    }
    
}
