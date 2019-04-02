//
//  File.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation

final public class HomeViewModelFactory {
    public static func create() -> HomeViewModel {
        let session = URLSession.shared
        let request = RequestService(session: session)
        let contentSerivce = ContentServiceApi(request: request)
        return HomeViewModel(contentSerivce: contentSerivce)
    }
}
