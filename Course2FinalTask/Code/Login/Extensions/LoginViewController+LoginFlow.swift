//
//  LoginViewController+LoginFlow.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension LoginViewController {
  
  func loginAttempt(login: String, password: String) {
    
    NetworkEngine.shared.loginAttemptAndGetFeed(login: login, password: password){result in
      switch result {
        case .failure(let error):
          print(error.localizedDescription)
        case .success(let feed):
          
         
          DispatchQueue.main.async {
            
            let navigationController = UINavigationController()
            let feedVC = FeedTableViewController(feed: feed)
            let window = UIApplication.shared.windows.first
            navigationController.viewControllers = [feedVC]
            window?.rootViewController = navigationController
            UIApplication.shared.windows.first?.unlockTheView()
            window?.makeKeyAndVisible()
          }
      }
    }
    
  }
}
