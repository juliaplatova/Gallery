//
//  PhotoService.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation
import SwiftyVK

class PhotoService {
    
    private var galleryViewController: GalleryViewController

    init(for VC: GalleryViewController) {
        galleryViewController = VC
    }

    public func loadPhotos(completion: @escaping (Bool) -> Void) {
        
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
                self.galleryViewController.photos = responseDecoded.items
                completion(true)
            } catch let parsingError {
                completion(false)
            }
        }.onError { error in
            completion(false)
        }.send()
    }
}
