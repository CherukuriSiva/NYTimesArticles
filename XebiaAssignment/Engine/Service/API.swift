//
//  API.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum API {
    case getContents(pageIndex: UInt, pageSize: UInt)
    
    var method: HTTPMethod {
        switch self {
        case .getContents:
            return .get
        }
    }
    
    var url: URL {
        var component = URLComponents()
        component.scheme = Constant.API.Scheme
        component.host = Constant.API.Host
        component.path = path
        component.queryItems = [URLQueryItem(name: "api-key", value: Constant.API.NewYorkTimesKey)]
        return component.url! //Force unwrapping to make sure URL never nil
    }
}

// MARK: - Privates

extension API {
    fileprivate var path: String {
        switch self {
        case .getContents:
            return "/svc/mostpopular/v2/emailed/1.json"
        }
    }
}

extension Constant {
    struct API {
        static let DefaultPageIndex: UInt = 0
        static let PageSize: UInt = 10
        static let NewYorkTimesKey = "8Oj9Xg6uX9rIZl3KhFVMDkBWgGzhQvGh"
        static let Scheme = "https"
        static let Host = "api.nytimes.com"
    }
}
