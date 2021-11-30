//
//  ArticleManager.swift
//  FirstApplication
//
//  Created by Antares on 24.11.2021.
//

import Foundation
import Alamofire

class ArticleManager {
    var articles: [ArticleItem] = []
    
    func parseArticles(sourceUrl: String,_ completionHandler: @escaping ([ArticleItem]) -> Void = {(_) in}) {
        let request = AF.request(sourceUrl)
        request.responseJSON() {
            (jsonData) in
            guard let data = jsonData.data else {return}
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let response = try? decoder.decode(ArticleResponse.self, from: data) else {return}
            completionHandler(response.articles)
        }
    }
    
    func parseAndReplaceArticles(sourceUrl: String,_ completionHandler: @escaping () -> Void = {}) {
        parseArticles(sourceUrl: sourceUrl) { (items) in
            self.articles = items
            completionHandler()
        }
    }
    
    func parseAndAddArticles(sourceUrl: String,_ completionHandler: @escaping () -> Void = {}) {
        parseArticles(sourceUrl: sourceUrl) { (items) in
            self.articles = self.articles + items
            completionHandler()
        }
    }
}
