//
//  ArticleItem.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import Kingfisher
struct ArticleItem: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    
}

extension UIImageView {
    func setImageFromUrl(_ urlToImage: String?) {
        guard let urlString = urlToImage else {return}
        kf.setImage(with: URL(string: urlString))
    }
}
