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
      if !isFieldsAreEmpty {
        view.endEditing(true)
        UIApplication.shared.windows.first?.lockTheView()
        
        loginAttempt(login: loginNameTextField.text!, password: passwordTextField.text!)
        return true
      }
    return true
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

