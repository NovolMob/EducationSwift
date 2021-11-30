//
//  ArticlesDataSource.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import Alamofire

class ArticlesDataSource {
    static private let manager = ArticleManager()
    static let ARTICLE_DEFAUL_SOURCE_URL = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=075acc000a034b4baf20d6a7815d0441"
    
    static func parseAndReplaceArticles(_ completionHandler: @escaping () -> Void = {}) {
        parseAndReplaceArticles(url: ARTICLE_DEFAUL_SOURCE_URL, completionHandler)
    }
    
    static func parseAndReplaceArticles(url: String, _ completionHandler: @escaping () -> Void = {}) {
        manager.parseAndReplaceArticles(sourceUrl: url, completionHandler)
    }
    
    static func parseAndAddArticles(_ completionHandler: @escaping () -> Void = {}) {
        parseAndAddArticles(url: ARTICLE_DEFAUL_SOURCE_URL, completionHandler)
    }
    
    static func parseAndAddArticles(url: String, _ completionHandler: @escaping () -> Void = {}) {
        manager.parseAndAddArticles(sourceUrl: url, completionHandler)
    }
    
    static func mixArticles() {
        var articles: [ArticleItem] = []
        for i in stride(from: manager.articles.count - 1, to: -1, by: -1) {
            articles.append(manager.articles[i])
        }
        manager.articles = articles
    }
    
    static func getArticleItem(index: Int) -> ArticleItem? {
        return manager.articles[index]
    }
    
    static func getArticleItemAmount() -> Int {
        return manager.articles.count
    }
}
