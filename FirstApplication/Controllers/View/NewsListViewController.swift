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
    }
    
}
