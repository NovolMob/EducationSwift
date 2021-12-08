//
//  PhotoCell.swift
//  FirstApplication
//
//  Created by Antares on 07.12.2021.
//

import UIKit
import PhotosUI
class PhotoCell: UICollectionViewCell {
    var photoAsset: PHAsset? {
        didSet {
            guard photoAsset != nil else { return }
            photo.image = photoAsset?.thumbnailImage
        }
    }
    @IBOutlet weak var photo: UIImageView!
    
}
