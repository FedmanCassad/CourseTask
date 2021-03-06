//
//  TabBarController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 26.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  var storedCurrentUser: User?
  
  override func viewDidLoad() {
    delegate = self
  }
  
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if let viewController = viewController as? UINavigationController {
      if viewController.viewControllers.isEmpty  {
        return false
      }
      else {
        return true
      }
    }
    return false
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
    DispatchQueue.global(qos: .userInteractive).async {
      if item.tag == 2 {
        guard let navigationController = self.viewControllers?.last as? UINavigationController else
        {return}
        if navigationController.viewControllers.isEmpty {
          NetworkEngine.shared.currentUser { [weak self] result in
            guard let self = self else {return}
            switch result {
              case .failure(let error):
                self.alert(error: error)
              case .success(let user):
                guard let user = user else {return}
                
                self.alert(error: .parsingFailed)
                return
                  
                  DispatchQueue.main.async {
                    let profileViewController = ProfileViewController(user: user)
                    self.storedCurrentUser = user
                    navigationController.viewControllers = [profileViewController]
                    _ = self.tabBarController(self, shouldSelect: navigationController)
                    self.selectedIndex = 2
                    Router.window?.unlockTheView()
                  }
            }
          }
          
        } else {
          DispatchQueue.main.async {
            guard let profileController = navigationController.viewControllers.last as? ProfileViewController, let user = NetworkEngine.shared.currentUser else {
              return}
            if profileController.profile.id != user.id {
              let profileViewController = ProfileViewController(user: user)
              navigationController.viewControllers = [profileViewController]
              self.selectedIndex = 2
              Router.window?.unlockTheView()
            }
            else {
              Router.window?.unlockTheView()
            }
          }
        }
      } else {
        DispatchQueue.main.async {
          Router.window?.unlockTheView()
        }
      }
    }
  }
}



