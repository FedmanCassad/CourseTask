//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
//  let tabBarController = TabBarController()
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initiateWindow()
    return true
  }
  
  private func initiateWindow() {
//    let feedImage = UIImage(named: "feed")
//    let profileImage = UIImage(named: "profile")
//    let addImage = UIImage(named: "plus")
//    let feedNavigationController = UINavigationController()
//    let addImageNavigationController = UINavigationController()
//    let profileNavigationController = UINavigationController()
//    let feedViewController = FeedTableViewController(feed: feed)
//    let imageLibraryViewController = AddImageViewController()
//    feedNavigationController.viewControllers = [feedViewController]
//    addImageNavigationController.viewControllers = [imageLibraryViewController]
//    
//    addImageNavigationController.tabBarItem = UITabBarItem(title: "New post", image: addImage, tag: 1)
//    feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
//    profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 2)
//    
//    tabBarController.viewControllers = [feedNavigationController, addImageNavigationController, profileNavigationController]
//    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    let vc = LoginViewController()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
  
}
