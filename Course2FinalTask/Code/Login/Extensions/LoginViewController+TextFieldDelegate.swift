//
//  LoginViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
 
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      passwordTextField.becomeFirstResponder()
      return true
    } else {
      return true
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let login = loginNameTextField.text,
          let password = passwordTextField.text
          else
    { return }
    delegate?.checkLogin(login: login) {[weak self] loginMatched in
      guard let self = self,
            let delegate = self.delegate else
      { return }
      if loginMatched {
        delegate.checkPassword(password: password) {passwordMatched in
          if passwordMatched {
            if PwdChecker.shared.isCridentialsExists(login: login , password: password) {
              //call to MainWorkFlow()
              print("Login succesful")
            }
          }
        }
      }
    }
  }
  
 @objc func textChanged(_ sender: UITextField) {
    if isFieldsAreEmpty {
      signInButton.layer.opacity = 0.3
      signInButton.isEnabled = false
    }
    else {
      signInButton.layer.opacity = 1
          signInButton.isEnabled = true
    }
 
  
  }

}

