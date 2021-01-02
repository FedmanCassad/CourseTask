
//  FeedTableView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 06.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.


import UIKit

class FeedTableViewController: UIViewController {
  
  var feed: [Post]
  let tableView = UITableView()
  
  init(feed: [Post] ) {
    self.feed = feed
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
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
    tableView.allowsSelection = false
    title = "Feed"
   
  }
  
}
