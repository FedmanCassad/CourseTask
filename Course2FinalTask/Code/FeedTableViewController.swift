//
//  FeedTableView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 06.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  let feed = DataProviders.shared.postsDataProvider.feed()
  var progile = DataProviders.shared.usersDataProvider
  let tableView = UITableView()
  
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return feed.count
  }
  
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cell = FeedCell()
    
    cell.configure(with: feed[indexPath.row])
    
    return cell.contentView.frame.maxY
    
  }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
    cell.configure(with: feed[indexPath.row])
    return cell
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
     super.viewDidLoad()
    tableView.frame = UIScreen.main.bounds
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
    tableView.separatorStyle = .none
    title = "Feed"
    
    
    
  }
  
}
