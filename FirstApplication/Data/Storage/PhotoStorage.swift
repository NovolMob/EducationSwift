//
//  PhotoStorage.swift
//  FirstApplication
//
//  Created by Antares on 08.12.2021.
//

import UIKit
import PhotosUI
class PhotoStorage {
    static let instance = PhotoStorage()
    var photos: PHFetchResult<PHAsset>?
    
    init() {
        PhotoWrapper.getAllPhotos(PhotoWrapper.getDataSortOptions()) {
            [weak self] (photos) in
            self?.photos = photos
        }
    }
    
}
