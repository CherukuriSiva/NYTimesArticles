//
//  Date.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

extension Date {
    var dateString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = DateFormat.date.format
        return dateFormater.string(from: self)
    }
}
