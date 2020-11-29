//
//  TabBarController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 26.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

//import UIKit
//import DataProvider
//
//class TabBarController: UITabBarController, UITabBarControllerDelegate {
//  
//  var storedCurrentUser: User?
//  
//  override func viewDidLoad() {
//    delegate = self
//  }
//  
//  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//    if let viewController = viewController as? UINavigationController {
//      if viewController.viewControllers.isEmpty  {
//        return false
//      }
//      else {
//        return true
//      }
//    }
//    return false
//  }
//  
//  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//    UIApplication.shared.keyWindow?.lockTheView()
//    DispatchQueue.global(qos: .userInteractive).async {
//      if item.tag == 2 {
//        guard let navigationController = self.viewControllers?.last as? UINavigationController else
//        {return}
//        if navigationController.viewControllers.isEmpty {
//          DataProviders.shared.usersDataProvider.currentUser(queue: .global(qos: .background)){ [weak self] user in
//            guard let self = self else {return}
//            guard let user = user else {
//              self.alert(completion: nil)
//              return
//            }
//            DispatchQueue.main.async {
//              let profileViewController = ProfileViewController(user: user)
//              self.storedCurrentUser = user
//              navigationController.viewControllers = [profileViewController]
//              _ = self.tabBarController(self, shouldSelect: navigationController)
//              self.selectedIndex = 2
//              UIApplication.shared.keyWindow?.unlockTheView()
//            }
//          }
//        } else {
//          DispatchQueue.main.async {
//            guard let profileController = navigationController.viewControllers.last as? ProfileViewController, let user = currentUser else {
//              return}
//            if profileController.profile.id != user.id {
//              let profileViewController = ProfileViewController(user: user)
//              navigationController.viewControllers = [profileViewController]
//              self.selectedIndex = 2
//              UIApplication.shared.keyWindow?.unlockTheView()
//            }
//            else {
//                UIApplication.shared.keyWindow?.unlockTheView()
//            }
//          }
//        }
//      } else {
//        DispatchQueue.main.async {
//          UIApplication.shared.keyWindow?.unlockTheView()
//        }
//      }
//    }
//  }
//  
//}
//
