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
  
  
  func goToProfilesList(users: [User],user: User, _ meaning: DestinationMeaning) {
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
    if navigationController.viewControllers.isEmpty {
      
      let profileController = ProfileViewController()
      
      profileController.profile = user
      navigationController.viewControllers = [profileController]
      navigationController.pushViewController(destinationVC, animated: true)
    }
      
    else if navigationController.viewControllers.count == 1 {
      let profileController = ProfileViewController()
      profileController.profile = user
      navigationController.viewControllers = [profileController]
      
      
      navigationController.pushViewController(destinationVC, animated: true)
    }
      
    else {
      let profileController = ProfileViewController()
      profileController.profile = user
      navigationController.viewControllers.append(profileController)
      navigationController.pushViewController(destinationVC, animated: true)
    }
  }
  
  func goToSelectedProfile(user: User) {
    let destinationVC = ProfileViewController()
    destinationVC.profile = user
    
    guard let tabBarController = tabBarController else {return}
    
    tabBarController.selectedIndex = 1
    
    guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {return}
    guard !navigationController.viewControllers.isEmpty else {
      navigationController.pushViewController(destinationVC, animated: true)
      return
    }
    
    if navigationController.viewControllers[0] is ProfileViewController && navigationController.viewControllers.count == 1 {
      navigationController.viewControllers.removeLast()
      navigationController.pushViewController(destinationVC, animated: true)}
    else {
      navigationController.pushViewController(destinationVC, animated: true)}
  }
  // Здесь функция для создания блокирующей интерфейс вьюхи.
  func lockTheView() {
    let lockView = ActivityIndicator()
    view.addSubview(lockView)
    
  }
  
  func unlockView() {
    view.subviews.forEach {
      if $0 is ActivityIndicator {
        $0.removeFromSuperview()
      }

    }
  }
}
