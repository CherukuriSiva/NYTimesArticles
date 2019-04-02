//
//  ContentCollectionViewCellViewModel.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import Foundation
import UIKit

final class ContentCollectionViewCellViewModel {
    let content: Content
    fileprivate let downloadImageService: DownloadImageServiceProtocol
    
    init(content: Content, downloadImageService: DownloadImageServiceProtocol) {
        self.content = content
        self.downloadImageService = downloadImageService
    }
}

// MARK: - ContentCollectionViewCellProtocol

extension ContentCollectionViewCellViewModel: ContentCollectionViewCellProtocol {
    var id: String {
        return content.url?.absoluteString ?? ""
    }
    
    var title: String {
        return content.title ?? ""
    }
    
    var date: String {
        return content.date?.dateString ?? "Apr 2"
    }
    
    var snippet: String {
        return content.abstract ?? ""
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        let mediaMetaData = content.multimedias?.last?.metadata
        let url = mediaMetaData?.last?.url ?? content.thumbnailImageURL
        
        guard let imageURL = url else { return }
        downloadImageService.download(url: imageURL) { [weak self] (response) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch response {
                case .success(let image):
                    completion(strongSelf.id, .success(image))
                case .failure(let error):
                    completion(strongSelf.id, .failure(error))
                }
            }
        }
    }
}
