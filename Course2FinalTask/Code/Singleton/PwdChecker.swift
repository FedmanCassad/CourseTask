//
//  PwdChecker.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
class PwdChecker {
  
  static var shared: PwdChecker = {
    let instance = PwdChecker()
    return instance
  }()
  
 let user = "user"
 let password = "qwerty"
  
  private init() {
}
  
  func isCridentialsExists (login: String, password: String) -> Bool{
    return login == user && password == password
  }
  
}
