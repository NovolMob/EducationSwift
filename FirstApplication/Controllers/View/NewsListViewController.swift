//
//  NewsListViewController.swift
//  FirstApplication
//
//  Created by Antares on 22.11.2021.
//

import UIKit
class NewsListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: ArticlesDataSource!
    
    override func viewDidLoad() {
        dataSource = ArticlesDataSource(tableView, self)
        tableView.refreshControl?.sendActions(for: .valueChanged)
        tableView.refreshControl?.beginRefreshing()
        
        dataSource.didSelect = {
            [weak self] (tableView, index) in
            guard let cell = (tableView.cellForRow(at: index) as? NewsCell) else { return }
            guard let detailsNews =  (self?.storyboard?.instantiateViewController(withIdentifier: "DetailsNews") as? DetailsNewsViewController) else { return }
            detailsNews.article = cell.article
            tableView.deselectRow(at: index, animated: false)
            self?.navigationController?.pushViewController(detailsNews, animated: true)
        }
    }
    
}
