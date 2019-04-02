//
//  HomeViewModelMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

@testable import XebiaAssignment

final class HomeViewModelMock {
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    var onMoreData: (([ContentCollectionViewCellProtocol]) -> Void)?
    var contentViewModels: [ContentCollectionViewCellProtocol] = []
    var isLoading = false
    var currentPageIndex = UInt(0)
    var didLoadMore = false
    var didRefresh = false
}

// MARK: - HomeViewModelProtocol

extension HomeViewModelMock: HomeViewModelProtocol {
    func contentViewModel(at index: Int) -> ContentCollectionViewCellProtocol? {
        return nil
    }
    
    func append(contentViewModel: ContentCollectionViewCellProtocol) {
        
    }
    
    func refresh() {
        didRefresh = true
    }
    
    func loadMore() {
        didLoadMore = true
    }
}
