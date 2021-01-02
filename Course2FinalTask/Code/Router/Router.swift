//
//  Router.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 04.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class Router: NSObject, NavigationCoordinator {
  
  static var selectedTab: Int = 0
  static let window = UIApplication.shared.windows.first
  static let feedNavigationController = UINavigationController()
  static let addImageNavigationController = UINavigationController()
  static let profileNavigationController = UINavigationController()
  static let tabBarController = TabBarController()
  static var feedViewController: FeedTableViewController? {
    feedNavigationController.viewControllers[0] as? FeedTableViewController
  }
  
  override private init() {}
  static func entryPoint(feed: [Post], currentUser: User) {
    let feedImage = UIImage(named: "feed")
    let profileImage = UIImage(named: "profile")
    let addImage = UIImage(named: "plus")
    let feedViewController = FeedTableViewController(feed: feed)
    let imageLibraryViewController = AddImageViewController()
    let profileVC = ProfileViewController(user: currentUser)
    profileVC.configure(user: currentUser)
    feedNavigationController.viewControllers = [feedViewController]
    addImageNavigationController.viewControllers = [imageLibraryViewController]
    profileNavigationController.viewControllers = [profileVC]
    addImageNavigationController.tabBarItem = UITabBarItem(title: "New post", image: addImage, tag: 1)
    feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
    profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 2)
    tabBarController.viewControllers = [feedNavigationController, addImageNavigationController, profileNavigationController]
    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }
  
  static func backToLoginView() {
    NetworkEngine.shared.logOut()
    let loginVC = LoginViewController()
    window?.rootViewController = loginVC
  }
  
  static func updateFeedIfNeeded(with post: Post) {
    feedViewController?.feed.insert(post, at: 0)
    feedViewController?.tableView.reloadData()
    feedViewController?.tableView.scrollToRow(at: .init(item: 0, section: 0), at: .top, animated: true)
    feedNavigationController.popToRootViewController(animated: true)
  }
  
}
