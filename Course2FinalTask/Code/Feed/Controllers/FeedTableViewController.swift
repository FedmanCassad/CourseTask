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
  var feed: [DataProvider.Post] = []
  
  let tableView = UITableView()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let group = DispatchGroup()
    group.enter()
    DataProviders.shared.postsDataProvider.feed(queue: .global(qos: .userInteractive)){[weak self] posts in
      guard let self = self else {return}
      guard let posts = posts else {
        self.alert(completion: nil)
        return}
      self.feed = posts
      group.leave()
    }
    group.wait()
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
