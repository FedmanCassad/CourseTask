//
//  FollowersFollowsTableView + DataSource.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 21.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension FollowersFollowsTableViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listOfUsers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "FollowsCell", for: indexPath) as! FollowsCell
      cell.configure(user: listOfUsers[indexPath.row])
      cell.delegate = self
  
      return cell
    }
}
