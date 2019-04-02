//
//  DownloadImageServiceMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit
import Foundation
@testable import XebiaAssignment

final class DownloadImageServiceMock: DownloadImageServiceProtocol {
    var completion: ((Response<UIImage>) -> Void)?
    
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void) {
        self.completion = completion
    }
}
