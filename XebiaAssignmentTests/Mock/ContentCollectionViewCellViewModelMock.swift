//
//  ContentCollectionViewCellViewModelMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit
@testable import XebiaAssignment

final class ContentCollectionViewCellViewModelMock {
    var completion: ((String, Response<(UIImage)>) -> Void)?
    var title = "title"
    var date = "date"
    var snippet = "snippet"
    var id = "id"
    var mockedContent: Content!
}

// MARK: - ContentCollectionViewCellProtocol

extension ContentCollectionViewCellViewModelMock: ContentCollectionViewCellProtocol {
    var content: Content {
        return mockedContent
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        self.completion = completion
    }
}
