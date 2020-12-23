//
//  FollowersTableView + TableViewDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 21.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension FollowersFollowsTableViewController: UITableViewDelegate {
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      let cell = FollowsCell()
      cell.configure(user: listOfUsers[indexPath.row])
      return cell.contentView.frame.maxY + 1
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let cell =  tableView.cellForRow(at: indexPath) as? FollowsCell else {return}
      UIApplication.shared.keyWindow?.lockTheView()
      goToSelectedProfile(user: cell.user)
    }
  
}
