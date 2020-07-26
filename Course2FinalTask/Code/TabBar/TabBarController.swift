//
//  TabBarController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 26.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
class TabBarController: UITabBarController {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item.tag == 1 {
      guard let navigationController = self.viewControllers?.last as? UINavigationController else {return}
      
      if navigationController.viewControllers.isEmpty {
        let profileViewController = ProfileViewController()
        profileViewController.profile =  DataProviders.shared.usersDataProvider.currentUser()
        navigationController.viewControllers = [profileViewController]
      }
      
      guard let profileController = navigationController.viewControllers.last as? ProfileViewController else {return}
      
      if profileController.profile?.id != DataProviders.shared.usersDataProvider.currentUser().id {
        let profileViewController = ProfileViewController()
        profileViewController.profile =  DataProviders.shared.usersDataProvider.currentUser()
        navigationController.viewControllers = [profileViewController]
      }
    }
  }
  
}
