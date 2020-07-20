//
//  Extenstions.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 08.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider


extension UIViewController: CellDelegate {
  
  
  func goToProfilesList(users: [User], _ meaning: DestinationMeaning) {
    let destinationVC = FollowersFollowsTableViewController()
    destinationVC.listOfUsers = users
    guard let tabBarController = tabBarController else {return}
    tabBarController.selectedIndex = 1
    
    guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {return}
    switch meaning {
      case .followers:
        destinationVC.title = "Following"
      case .follows:
        destinationVC.title = "Follows"
    }
    navigationController.pushViewController(destinationVC, animated: true)
  }
  
  
  func goToSelectedProfile(user: User) {
    let destinationVC = ProfileViewController()
    destinationVC.profile = user
    guard let tabBarController = tabBarController else {return}
    tabBarController.selectedIndex = 1
    guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {return}
    navigationController.pushViewController(destinationVC, animated: true)
    
  }
  
  
}
