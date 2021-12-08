//
//  ArticlesDataSource.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
import Alamofire

class ArticlesDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var articles: [ArticleItem] = []
    private let pageSize: Int = 5
    private var totalResults: Int = 0
    private var triggerOffset: CGFloat = 50.0
    private var isLoadingNews: Bool = false
    private let manager = ArticleManager()
//    private let apiKey = "075acc000a034b4baf20d6a7815d0441"
    private let apiKey = "c1ea3aa4b4904d1f9103f6f60ad5bd0d"
    
    
    var didSelect: (UITableView, IndexPath) -> Void = {
        (_, _) in
    }
    private var controller: UIViewController!
    private var tableView: UITableView!
    
    struct Configuration {
        static let apiKeyTag = "{apiKey}"
        static let pageTag = "{page}"
        static let pageSizeTag = "{pageSize}"
        static let newsApiUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=\(pageSizeTag)&page=\(pageTag)&apiKey=\(apiKeyTag)"
        
        static func createUrl(_ apiKey: String,_ pageSize: Int, _ page: Int) -> String {
            return newsApiUrl
                .replacingOccurrences(of: apiKeyTag, with: apiKey)
                .replacingOccurrences(of: pageSizeTag, with: "\(pageSize)")
                .replacingOccurrences(of: pageTag, with: "\(page)")
        }
    }
    
    init(_ tableView: UITableView, _ controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        super.init()
        
        setup()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ViewNewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
    }
    
    @objc private func refreshTable(_: Any) {
        isLoadingNews = true
        parseAndReplaceArticles(1) {
            [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
            self?.isLoadingNews = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(tableView, indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = tableView.contentOffset.y + triggerOffset
        let maximumOffset = tableView.contentSize.height - tableView.frame.size.height
        if (maximumOffset - currentOffset <= 0 && canLoadMoreNews()) {
            loadMoreNews()
        }
    }
    
    func parseAndReplaceArticles(_ page: Int, _ completionHandler: @escaping () -> Void = {}) {
        parseAndReplaceArticles(sourceUrl: Configuration.createUrl(apiKey, pageSize, page), completionHandler)
    }
    
    func canLoadMoreNews() -> Bool {
        return totalResults > articles.count && !isLoadingNews;
    }
    
    func loadMoreNews() {
        isLoadingNews = true
        tableView.tableFooterView?.isHidden = false
        parseAndAddArticles((articles.count / pageSize) + 1) {
            [weak self] in
            self?.tableView.reloadData()
            self?.isLoadingNews = false
            self?.tableView.tableFooterView?.isHidden = true
        }
    }
    
    func parseAndAddArticles(_ page: Int, _ completionHandler: @escaping () -> Void = {}) {
        parseAndAddArticles(sourceUrl: Configuration.createUrl(apiKey, pageSize, page), completionHandler)
    }
    
    func parseAndReplaceArticles(sourceUrl: String,_ completionHandler: @escaping () -> Void = {}) {
        manager.parseArticles(sourceUrl: sourceUrl) {  [weak self] (response) in
            self?.articles = response.articles
            self?.totalResults = response.totalResults
            completionHandler()
        }
    }
    
    func parseAndAddArticles(sourceUrl: String,_ completionHandler: @escaping () -> Void = {}) {
        manager.parseArticles(sourceUrl: sourceUrl) {  [weak self] (response) in
            self?.articles = (self?.articles ?? []) + response.articles
            completionHandler()
        }
    }
}
