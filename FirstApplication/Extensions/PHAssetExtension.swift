//
//  PHAssetExtension.swift
//  FirstApplication
//
//  Created by Antares on 08.12.2021.
//

import PhotosUI
extension PHAsset {
    var thumbnailImage : UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        }
    }
    var fullImage : UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var fullImage = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: PhotoWrapper.getImageSize(asset: self), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                fullImage = result!
            })
            return fullImage
        }
    }
}
