//
//  LoginInspector.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
  
  func checkLogin(login: String, handler: (Bool) -> Void) {
    handler(login == PwdChecker.shared.user)
  }
  
  func checkPassword(password: String, handler: (Bool) -> Void) {
    handler(password == PwdChecker.shared.password)
  }
  
}
