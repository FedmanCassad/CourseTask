import UIKit

class LoginViewController: UIViewController {

  //MARK: - Properties
  let viewModel: ILoginViewModel
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
//    button.addTarget(self, action: #selector(signIn(sender:)), for: .touchUpInside)
    return button
  }()

//MARK: - Initializers
  init(viewModel: ILoginViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil  )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Lifecycle
  override func viewDidLoad() {
    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  override func viewDidLayoutSubviews() {
    view.addSubview(loginNameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(signInButton)
  }
}

// - Textfield delegate
extension LoginViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      passwordTextField.becomeFirstResponder()
      return true
    } else {
      if !isFieldsAreEmpty {
        view.endEditing(true)
        return true
      }
      return true
    }
  }

  @objc func textChanged(_ sender: UITextField) {
    signInButton.isEnabled = viewModel.authFieldNotEmpty
    signInButton.layer.opacity = viewModel.loginButtonOpacityLevel
  }
}

