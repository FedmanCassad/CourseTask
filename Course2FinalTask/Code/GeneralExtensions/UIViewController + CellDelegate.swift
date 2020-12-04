//
//  Extenstions.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 08.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit




extension UIViewController: FeedCellDelegate {
  
  
//  func goToProfilesList(users: [User],user: User, _ meaning: DestinationMeaning) {
//
//    let destinationVC = FollowersFollowsTableViewController()
//
//    destinationVC.listOfUsers = users
//    guard let tabBarController = tabBarController else {return}
//    tabBarController.selectedIndex = 2
//    guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {return}
//    switch meaning {
//      case .followers:
//        destinationVC.title = "Following"
//      case .follows:
//        destinationVC.title = "Follows"
//    }
//
//    if navigationController.viewControllers.isEmpty {
//
//      let profileController = ProfileViewController(user: user)
//
//      navigationController.viewControllers = [profileController]
//      navigationController.pushViewController(destinationVC, animated: true)
//    }
//
//    else if navigationController.viewControllers.count == 1 {
//      let profileController = ProfileViewController(user: user)
//      navigationController.viewControllers = [profileController]
//
//
//      navigationController.pushViewController(destinationVC, animated: true)
//    }
//
//    else {
//      let profileController = ProfileViewController(user: user)
//      navigationController.viewControllers.append(profileController)
//      navigationController.pushViewController(destinationVC, animated: true)
//    }
//    UIApplication.shared.keyWindow?.unlockTheView()
//  }
//
//  func goToSelectedProfile(user: User) {
//    _ = ProfileViewController(user: user){[weak self] controller in
//      guard let self = self else {return}
//      guard let tabBarController = self.tabBarController else {return}
//      tabBarController.selectedIndex = 2
//      guard let navigationController = tabBarController.selectedViewController as? UINavigationController else {return}
//      guard !navigationController.viewControllers.isEmpty else {
//        navigationController.pushViewController(controller, animated: true)
//        return
//      }
//      if navigationController.viewControllers[0] is ProfileViewController {
//        navigationController.viewControllers.removeLast()
//        navigationController.pushViewController(controller, animated: false)
//      }
//      else {
//        navigationController.pushViewController(controller, animated: true)
//      }
//    }
//    UIApplication.shared.keyWindow?.unlockTheView()
//  }
//
//  func alert(completion: ((UIViewController) -> ())?) {
//    let alertController = UIAlertController(title: "Unknown error!", message: "Please try again later", preferredStyle: .alert)
//    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//    self.present(alertController, animated: true, completion: nil)
//  }
//
}
