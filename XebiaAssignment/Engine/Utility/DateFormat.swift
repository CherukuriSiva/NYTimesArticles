//
//  DateFormat.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

enum DateFormat {
    case date
    case iso8601Date
    case iso8601CombinedDateAndTime
    case custom(format: String)
    
    var format: String {
        switch self {
        case .iso8601Date:
            return "yyyy-MM-dd"
        case .iso8601CombinedDateAndTime:
            return "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        case .date:
            return "dd/MM/yyyy"
        case .custom(let format):
            return format
        }
    }
}
