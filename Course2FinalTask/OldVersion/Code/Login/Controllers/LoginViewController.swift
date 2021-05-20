//
//  LoginViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 30.11.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  let coreDataService: CoreDataService = CoreDataService(modelName: "OfflineCache")
  var loginManager = LoginManager()
  var isFieldsAreEmpty: Bool  {
    guard let loginString = loginNameTextField.text,
          let passwordString = passwordTextField.text else {
      return true
    }
    return loginString.isEmpty || passwordString.isEmpty
  }
  
  lazy var loginNameTextField: UITextField = {
    let textField = UITextField()
    textField.autocorrectionType = .no
    textField.tag = 0
    textField.delegate = self
    textField.returnKeyType = .next
    textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    textField.placeholder = "Login"
    textField.keyboardType = .emailAddress
    textField.frame.size.width = view.frame.width - 32
    textField.frame.size.height = 40
    textField.center.x = view.center.x
    textField.borderStyle = .roundedRect
    textField.frame.origin.y = view.safeAreaInsets.top + 30
    return textField
  }()
  
  lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.autocorrectionType = .no
    textField.delegate = self
    textField.tag = 1
    textField.returnKeyType = .send
    textField.isSecureTextEntry = true
    textField.keyboardType = .asciiCapable
    textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    textField.placeholder = "Password"
    textField.frame.size.width = view.frame.width - 32
    textField.frame.size.height = 40
    textField.center.x = view.center.x
    textField.borderStyle = .roundedRect
    textField.frame.origin.y = loginNameTextField.frame.maxY + 8
    return textField
  }()
  
  lazy var signInButton: UIButton = {
    let button = UIButton()
    button.frame.size.width = view.frame.width - 32
    button.frame.size.height = 50
    button.center.x = view.center.x
    button.frame.origin.y = passwordTextField.frame.maxY + 100
    button.backgroundColor = LoginViewController.hexStringToUIColor(hex: "#007AFF")
    button.tintColor = .white
    button.setTitle("Sign in", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    button.layer.cornerRadius = 5
    button.layer.opacity = 0.3
    button.addTarget(self, action: #selector(signIn(sender:)), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    networkEngine.setManagedObjectContext(context: coreDataService.getContext())
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if loginManager.hasToken {
      loginManager.validateToken {[weak self] result in
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
          Router.window?.unlockTheView()
          self?.alert(error: error)
        case .success(_):
          guard let user = self?.loginManager.currentUser  else {
            self?.alert(error: ErrorHandlingDomain.unknownError)
            Router.window?.unlockTheView()
            return
          }
          self?.networkEngine.getFeed {result in
            switch result {
            case .failure(let error):
              Router.window?.unlockTheView()
              self?.alert(error: error)
            case .success(let feed):
              self?.coreDataService.save()
              DispatchQueue.main.async {
                self?.loginNameTextField.text = "•••••••••••••"
                self?.passwordTextField.text = "•••••••••••••"
                Router.window?.unlockTheView()
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let self = self else { return }
                Router.entryPoint(feed: feed, currentUser: user, coreDataService: self.coreDataService)
              }
            }
          }
        }
      }
    } else {
      Router.window?.unlockTheView()
    }
  }
  
  override func viewDidLayoutSubviews() {
    view.addSubview(loginNameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(signInButton)
  }
}


