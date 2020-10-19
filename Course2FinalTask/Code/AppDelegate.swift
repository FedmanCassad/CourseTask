//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider

// Я знаю что глобальные перменные это табу, но - это константа во-первых:))), во-вторых: он у нас не меняется, он нужен, и зачем его каждый раз дергать если он понадобится из тормозного метода дата провайдера мне не совсем понятно. Для скорости пусть будет.
var currentUser: User? = {
  let group = DispatchGroup()
  group.enter()
  var curUser: User? = nil
  DataProviders.shared.usersDataProvider.currentUser(queue: .global(qos: .userInteractive)){user in
    guard let recievedUser = user
      else {return}
    curUser = recievedUser
    group.leave()
  }
  group.wait()
  return curUser
}()

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
    let addImage = UIImage(named: "plus")
    let feedNavigationController = UINavigationController()
    let addImageNavigationController = UINavigationController()
    let profileNavigationController = UINavigationController()
    let feedViewController = FeedTableViewController()
    let imageLibraryViewController = AddImageViewController()
    feedNavigationController.viewControllers = [feedViewController]
    addImageNavigationController.viewControllers = [imageLibraryViewController]
    
    addImageNavigationController.tabBarItem = UITabBarItem(title: "New post", image: addImage, tag: 1)
    feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 0)
    profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 2)
    
    tabBarController.viewControllers = [feedNavigationController, addImageNavigationController, profileNavigationController]
    tabBarController.tabBar.unselectedItemTintColor = .lightGray
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = self.tabBarController
    window?.makeKeyAndVisible()
  }
  
}
