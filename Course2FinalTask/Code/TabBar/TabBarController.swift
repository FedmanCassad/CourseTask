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
    
    var storedCurrentUser: User?
    if item.tag == 1 {
       lockTheView()
      guard let navigationController = self.viewControllers?.last as? UINavigationController else
      {return}
   
      
        DataProviders.shared.usersDataProvider.currentUser(queue: .global(qos: .userInitiated)){ [weak self] user in
                    guard let self = self else {return}
          if navigationController.viewControllers.isEmpty {
          let profileViewController = ProfileViewController()
          storedCurrentUser = user
          profileViewController.profile = user
          navigationController.viewControllers = [profileViewController]
            self.tabBarController?.reloadInputViews()
          DispatchQueue.main.async {
            self.unlockView()
          }
          }
          else {
            guard let profileController = navigationController.viewControllers.last as? ProfileViewController, let user = storedCurrentUser else {return}
            if profileController.profile?.id != user.id {
              let profileViewController = ProfileViewController()
              profileViewController.profile = user
              navigationController.viewControllers = [profileViewController]
               DispatchQueue.main.async {
                         self.unlockView()
                       }
            }
          }
        }
      }
    }
  }

