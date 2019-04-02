//
//  APIError.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

enum APIError: Int {
    case unexpected = -1
    case mapping = -2
    case serverError = -3
    
    var code: Int {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .unexpected:
            return NSLocalizedString("Unexpected error", comment: "")
        case .mapping:
            return NSLocalizedString("Cannot mapping object", comment: "")
        case .serverError:
            return NSLocalizedString("Cannot connect to server", comment: "")
        }
    }
    
    var error: NSError {
        return NSError(domain: "com.xebia.XebiaAssignment.error", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
