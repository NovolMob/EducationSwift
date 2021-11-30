//
//  DetailsNewsViewController.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import SafariServices

class DetailsNewsViewController: UIViewController {
    var lastArticleItem: ArticleItem! = nil
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        if (lastArticleItem != nil) {
            update()
        }
    }
    
    func update() {
        lastArticleItem.setImageFor(imageView: newsImage)
        titleNews.text = lastArticleItem.title
        details.text = lastArticleItem.description
    }
    
    @IBAction func actionMoreDetailsButton(_ sender: Any) {
        if let url = URL(string: lastArticleItem.url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
