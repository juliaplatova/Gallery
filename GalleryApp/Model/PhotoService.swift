//
//  PhotoService.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation
import SwiftyVK

class PhotoService {

    var photos : [Photo] = []
    
    static let shared = PhotoService()

    public func fetchPhotos(completion: @escaping (Bool) -> Void) {
        
        let requestParameters : Dictionary<Parameter, Optional<String>> = [
            .ownerId: VKRequestConstants.groupID,
            .albumId: VKRequestConstants.photoAlbumID,
            .photoSizes: VKRequestConstants.size,
            .rev: VKRequestConstants.rev,
            .offset: VKRequestConstants.offset,
            .count: VKRequestConstants.count
        ]
        
        VK.API.Photos.get(requestParameters).onSuccess { response in
            do {
                let responseDecoded = try JSONDecoder().decode(PhotoResponse.self, from: response)
//                self.galleryViewController.photos = responseDecoded.items
                self.photos = responseDecoded.items
                completion(true)
            } catch let parsingError {
                completion(false)
            }
        }.onError { error in
            completion(false)
        }.send()
    }
}
