//
//  DetailsNewsViewController.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import SafariServices

class DetailsNewsViewController: UIViewController {
    var article: ArticleItem!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let article = article else { return }
        titleNews.text = article.title
        details.text = article.description
        newsImage.setImageFromUrl(article.urlToImage)
    }
    
    @IBAction func actionMoreDetailsButton(_ sender: Any) {
        guard let url = article.url else { return }
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
