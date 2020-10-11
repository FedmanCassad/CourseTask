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
      
      let profileController = ProfileViewController(user: user)
      
      navigationController.viewControllers = [profileController]
      navigationController.pushViewController(destinationVC, animated: true)
    }
      
    else if navigationController.viewControllers.count == 1 {
      let profileController = ProfileViewController(user: user)
      navigationController.viewControllers = [profileController]
      
      
      navigationController.pushViewController(destinationVC, animated: true)
    }
      
    else {
      let profileController = ProfileViewController(user: user)
      navigationController.viewControllers.append(profileController)
      navigationController.pushViewController(destinationVC, animated: true)
    }
    
  }
  
  func goToSelectedProfile(user: User) {
    print(Thread.current)
    _ = ProfileViewController(user: user){[weak self] controller in
      guard let self = self else
      {return}
      guard let tabBarController = self.tabBarController else
      {return}
      tabBarController.selectedIndex = 1
      guard let navigationController = tabBarController.selectedViewController as? UINavigationController else
      {return}
      print(navigationController.viewControllers.count)
      guard !navigationController.viewControllers.isEmpty else {
        print("Сработал гард если нав контроллер ПУСТОЙ")
        navigationController.pushViewController(controller, animated: true)
        return
      }
      
      if navigationController.viewControllers[0] is ProfileViewController {
        print("Сработал гард где котроллер не пустой и первый котроллер - профиль")
        navigationController.viewControllers.removeLast()
        navigationController.pushViewController(controller, animated: false)
      }
      else {
        print("Сработал гард где котроллер не пустой и первый котроллер - не профиль")
        navigationController.pushViewController(controller, animated: true)
      }
      
    }
    UIApplication.shared.keyWindow?.unlockView()
  }
  
}
