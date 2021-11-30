//
//  NewsListViewController.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "ViewNewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        refreshControl.sendActions(for: .valueChanged)
        refreshControl.beginRefreshing()
    }
    
    @objc private func refreshTable(_: Any) {
        ArticlesDataSource.parseAndReplaceArticles {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticlesDataSource.getArticleItemAmount();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setArticle(articleItem: ArticlesDataSource.getArticleItem(index: indexPath.row)!)
        if (ArticlesDataSource.getArticleItemAmount() == (indexPath.row + 1)) {
            ArticlesDataSource.parseAndAddArticles {
                tableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = (tableView.cellForRow(at: indexPath) as? NewsCell) else { return }
        guard let detailsNews =  (storyboard?.instantiateViewController(withIdentifier: "DetailsNews") as? DetailsNewsViewController) else { return }
        detailsNews.lastArticleItem = cell.lastArticleItem
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(detailsNews, animated: true)
    }
    
}
