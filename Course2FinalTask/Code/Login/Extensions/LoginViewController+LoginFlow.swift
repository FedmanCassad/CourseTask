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
    NetworkEngine.shared.loginAndMoveToFeed(login: login, password: password)
  }
}
