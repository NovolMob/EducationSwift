//
//  ImageViewExtention.swift
//  FirstApplication
//
//  Created by Antares on 08.12.2021.
//

import UIKit
extension UIImageView {
    func setImageFromUrl(_ urlToImage: String?) {
        guard let urlString = urlToImage else {
            image = nil
            return
        }
        kf.setImage(with: URL(string: urlString))
    }
}
