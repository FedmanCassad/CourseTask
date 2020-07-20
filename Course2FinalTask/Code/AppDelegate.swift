//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider
var usersData = DataProviders.shared.usersDataProvider
var postsData = DataProviders.shared.postsDataProvider



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let feedImage = UIImage(named: "feed")
    let profileImage = UIImage(named: "profile")
    let tabBarController = UITabBarController()
    let feedViewController = FeedTableViewController()
    let profileViewController = ProfileViewController()
    profileViewController.profile =  DataProviders.shared.usersDataProvider.currentUser()
    let feedNavigationController = UINavigationController()
    let profileNavigationController = UINavigationController()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    feedNavigationController.viewControllers = [feedViewController]
    profileNavigationController.viewControllers = [profileViewController]
    
    tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, selectedImage: feedImage)
    profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImage)
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }
}
