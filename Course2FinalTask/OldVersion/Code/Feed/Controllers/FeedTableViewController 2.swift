//
//  FeedTableView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 06.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
class FeedTableViewController: UIViewController {

  let feed = postsData.feed()
  let tableView = UITableView()

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.frame = UIScreen.main.bounds
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
    tableView.separatorStyle = .none
    title = "Feed"
  }
  
}
