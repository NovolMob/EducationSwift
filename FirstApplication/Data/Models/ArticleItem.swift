//
//  ArticleItem.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import Kingfisher
struct ArticleItem: Decodable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    
    func setImageFor(imageView: UIImageView) {
        imageView.kf.setImage(with: URL(string: urlToImage))
    }
}
