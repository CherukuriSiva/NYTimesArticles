//
//  ContentServiceApi.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

protocol ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void)
}

final class ContentServiceApi {
    fileprivate let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - ContentServiceApiProtocol

extension ContentServiceApi: ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void) {
        let responseCompletion: (Response<ContentResponse>) -> Void = { response in
            switch response {
            case .success(let contentResponse):
                switch contentResponse.status {
                case .ok:
                    completion(.success(contentResponse.contents))
                case .unknown:
                    completion(.failure(APIError.serverError.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        let api: API = .getContents(pageIndex: pageIndex, pageSize: pageSize)
        request.object(from: api, completion: responseCompletion)
    }
}
