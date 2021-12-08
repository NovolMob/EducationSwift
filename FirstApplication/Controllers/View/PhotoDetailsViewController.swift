//
//  PhotoDetailsViewController.swift
//  FirstApplication
//
//  Created by Antares on 08.12.2021.
//

import UIKit
import Photos
class PhotoDetailsViewController: UIViewController {
    var photoAsset: PHAsset?
    @IBOutlet weak var photo: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        guard photoAsset != nil else { return }
        photo.image = photoAsset?.fullImage
    }
}
