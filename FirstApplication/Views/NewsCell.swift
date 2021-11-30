//
//  NewsCell.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
class NewsCell: UITableViewCell {
    var lastArticleItem: ArticleItem!
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func setArticle(articleItem: ArticleItem) {
        lastArticleItem = articleItem
        articleItem.setImageFor(imageView: newsImage)
        title.text = articleItem.title
        details.text = articleItem.description
    }
}
