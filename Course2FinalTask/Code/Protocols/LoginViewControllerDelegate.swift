//
//  LoginViewControllerDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
  func checkLogin(login: String, handler: (Bool) -> Void)
  func checkPassword(password: String, handler: (Bool) -> Void)
}
