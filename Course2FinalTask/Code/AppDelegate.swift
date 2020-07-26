//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider
//var usersData = DataProviders.shared.usersDataProvider
//var postsData = DataProviders.shared.postsDataProvider



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  let tabBarController = TabBarController()
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initiateWindow()
    return true
  }
  
  private func initiateWindow() {
    let feedImage = UIImage(named: "feed")
    let profileImage = UIImage(named: "profile")
    
    let feedNavigationController = UINavigationController()
    let profileNavigationController = UINavigationController()
    
    let feedViewController = FeedTableViewController()
    
    feedNavigationController.viewControllers = [feedViewController]
    feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
    profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 1)
    
    tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }
  
}
