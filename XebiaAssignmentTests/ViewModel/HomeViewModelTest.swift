//
//  HomeViewModelTest.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import XCTest
@testable import XebiaAssignment

class HomeViewModelTest: XCTestCase {
    
    var sut: HomeViewModel!
    var contentSerivce: ContentServiceApiMock!
    var content: Content!
    var downloadImageService: DownloadImageServiceMock!
    
    override func setUp() {
        super.setUp()
        contentSerivce = ContentServiceApiMock()
        downloadImageService = DownloadImageServiceMock()
        sut = HomeViewModel(contentSerivce: contentSerivce)
    }
    
    func testContentViewModel() {
        XCTAssertNil(sut.contentViewModel(at: 0))
        
        //Given:
        let viewModel = ContentCollectionViewCellViewModel(content: mockedContent(), downloadImageService: downloadImageService)
        sut.append(contentViewModel: viewModel)
        sut.append(contentViewModel: viewModel)
        sut.append(contentViewModel: viewModel)
        
        //When:
        let viewModel0 = sut.contentViewModel(at: -1)
        let viewModel1 = sut.contentViewModel(at: 0)
        let viewModel2 = sut.contentViewModel(at: 1)
        let viewModel3 = sut.contentViewModel(at: 2)
        let viewModel4 = sut.contentViewModel(at: 3)
        
        //Then:
        XCTAssertNil(viewModel0)
        XCTAssertNotNil(viewModel1)
        XCTAssertNotNil(viewModel2)
        XCTAssertNotNil(viewModel3)
        XCTAssertNil(viewModel4)
    }
    
    func testAppendContentViewModel() {
        let viewModel = ContentCollectionViewCellViewModel(content: mockedContent(), downloadImageService: downloadImageService)
        sut.append(contentViewModel: viewModel)
        XCTAssertEqual(sut.contentViewModels.count, 1)
        
        sut.append(contentViewModel: viewModel)
        XCTAssertEqual(sut.contentViewModels.count, 2)
        
        sut.append(contentViewModel: viewModel)
        XCTAssertEqual(sut.contentViewModels.count, 3)
    }
}

// MARK: - Test refresh method

extension HomeViewModelTest {
    func testRefreshSuccess() {
        //Given:
        let content = mockedContent()
        let contents =  [content, content, content]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.contentViewModels.count, contents.count)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        sut.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        XCTAssertTrue(sut.isLoading)
        contentSerivce.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(contentSerivce.pageIndex, 0)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
    
    func testRefreshError() {
        //Given:
        let message = "Error message"
        let expectedError = mockedError(message: message)
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { [weak self] errorMessage in
            XCTAssertEqual(self?.sut.contentViewModels.count, 0)
            XCTAssertEqual(errorMessage, message)
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        sut.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        XCTAssertTrue(sut.isLoading)
        contentSerivce.completion?(.failure(expectedError))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(contentSerivce.pageIndex, 0)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
}

// MARK: - Test loadMore method

extension HomeViewModelTest {
    func testLoadMoreSuccess() {
        //Given:
        let content = mockedContent()
        let contents =  [content, content, content]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.contentViewModels.count, contents.count)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        sut.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }
        
        //When:
        sut.loadMore()
        XCTAssertTrue(sut.isLoading)
        contentSerivce.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(contentSerivce.pageIndex, 1)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
    
    func testLoadMoreError() {
        //Given:
        let message = "Error message"
        let expectedError = mockedError(message: message)
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { [weak self] errorMessage in
            XCTAssertEqual(self?.sut.contentViewModels.count, 0)
            XCTAssertEqual(errorMessage, message)
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        sut.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }
        
        //When:
        sut.loadMore()
        XCTAssertTrue(sut.isLoading)
        contentSerivce.completion?(.failure(expectedError))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(contentSerivce.pageIndex, 1)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
}

// MARK: - Privates

extension HomeViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Media(metadata: [MediaMetadata(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210)], type: .unknown, caption: "caption", copyright: "copyright1")], byline: "byline", source: "source")
    }
    
    fileprivate func mockedError(message: String) -> Error {
        return NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
