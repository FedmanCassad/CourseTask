//
//  FollowersTableView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 17.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FollowersFollowsTableViewController: UIViewController {
  
  var listOfUsers = Array<User>()
  var tableView = UITableView()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.frame = UIScreen.main.bounds
    tableView.register(FollowsCell.self, forCellReuseIdentifier: "FollowsCell")
    
    view.addSubview(tableView)
    
    view.backgroundColor = .white
    
    tableView.delegate = self
    tableView.dataSource = self
   
  }
  
}
