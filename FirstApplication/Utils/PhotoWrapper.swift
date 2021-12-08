//
//  PhotoWrapper.swift
//  FirstApplication
//
//  Created by Antares on 08.12.2021.
//

import UIKit
import PhotosUI
class PhotoWrapper {
    
    
    static func runIfAuthorized(handler: @escaping () -> Void) {
        if (PHPhotoLibrary.authorizationStatus() == .authorized) {
            handler()
            return
        } else {
            tryToLogIn() {
                status in
                if (status == .authorized) {
                    handler()
                }
            }
        }
    }
    
    static func getDataSortOptions() -> PHFetchOptions {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
          NSSortDescriptor(
            key: "creationDate",
            ascending: false)
        ]
        return allPhotosOptions
    }
    
    static func tryToLogIn(answerHandler: @escaping (PHAuthorizationStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
          answerHandler(status)
        }
    }
    
    static func getAllPhotos(_ options: PHFetchOptions, _ photosHandler: @escaping (PHFetchResult<PHAsset>) -> Void) {
        runIfAuthorized() {
            photosHandler(PHAsset.fetchAssets(with: .image, options: options))
        }
    }
    
    static func getImageSize(asset: PHAsset) -> CGSize {
        return CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
    }
    
    static func getImage(asset: PHAsset, size: CGSize, requestOptions: PHImageRequestOptions, _ imageHandler: @escaping (UIImage) -> Void) {
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: requestOptions) {
            (image, _) in
            guard let image = image else {return}
            imageHandler(image)
        }
    }
    
}
