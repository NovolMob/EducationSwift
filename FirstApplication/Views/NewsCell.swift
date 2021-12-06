//
//  NewsCell.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
class NewsCell: UITableViewCell {
    var article: ArticleItem! {
        didSet {
            guard let article = article else { return }
            title.text = article.title
            details.text = article.description
            newsImage.setImageFromUrl(article.urlToImage)
        }
    }
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
}
