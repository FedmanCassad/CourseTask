//
//  SharePostViewController+TextFieldDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 19.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension SharePostViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
