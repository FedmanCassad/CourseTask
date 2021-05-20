//
//  LoginViewController+LoginFlow.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension LoginViewController {
  var networkEngine: NetworkEngine {
    return NetworkEngine.shared
  }
  func loginAttempt(login: String, password: String) {
    loginManager.getToken(login: login, password: password) {[weak self] result in
      switch result {
      case .failure(let error):
        Router.window?.unlockTheView()
        self?.alert(error: error)
      case .success(_):
        guard let user = self?.loginManager.currentUser else {
          Router.window?.unlockTheView()
          self?.alert(error: ErrorHandlingDomain.unknownError)
          return
        }
        self?.networkEngine.getFeed { [weak self] result in
          switch result {
          case .failure(let error):
            Router.window?.unlockTheView()
            self?.alert(error: error)
          case .success(let feed):
            Router.window?.unlockTheView()
            guard let self = self else { return }
            Router.entryPoint(feed: feed, currentUser: user, coreDataService: self.coreDataService)
          }
        }
      }
    }
  }
  
  @objc func signIn(sender: UIButton) {
      view.endEditing(true)
      Router.window?.lockTheView()
      loginAttempt(login: loginNameTextField.text!, password: passwordTextField.text!)
  }
}
