import Foundation


protocol ILoginViewModel {
  var authFieldNotEmpty: Bool { get }
  var loginButtonOpacityLevel: Float { get }
  var loginText: String? { get set }
  var passwordText: String? { get set }
  var hasToken: Bool { get set }
  var isTokenValid: Bool { get set }
  var authorizationResult: ((Result<Bool, ErrorHandlingDomain>) -> Void)? { get set }
  func signInButtonTapped() -> Void
  func initialCheckingCredentials() -> Void
}

class LoginViewModel: ILoginViewModel {

  var authFieldNotEmpty: Bool {
    guard let login = loginText,
          let password = passwordText else { return false}
    return login.isEmpty || password.isEmpty ? false : true
  }

  var loginButtonOpacityLevel: Float {
    return authFieldNotEmpty ? 1 : 0.3
  }

  var loginText: String?
  var passwordText: String?
  var hasToken: Bool = false
  var isTokenValid: Bool = false
  var authorizationResult: ((Result<Bool, ErrorHandlingDomain>) -> Void)?
  private let networkService: INetworkEngine = 

  func signInButtonTapped() {

  }

  func initialCheckingCredentials() {

  }


}
