//
//  Pageable.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

public protocol Pageable {
    var isLoading: Bool { get }
    var currentPageIndex: UInt { get }
    func refresh()
    func loadMore()
}
