//
//  ImageLoadable.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

public protocol ImageLoadable {
    var id: String { get }
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void)
}
