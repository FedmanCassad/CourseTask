//import Foundation
//
//class LoginManager {
//  private var token: String?
//  var currentUser: User?
//  private var networkEngine: NetworkEngine = NetworkEngine.shared
//  var isTokenValid: Bool?
//
//  var hasUser: Bool {
//    currentUser != nil
//  }
//
//  var hasToken: Bool {
//    token != nil
//  }
//
//  init() {
//    guard let tokenData = KeyChainService.receive(key: "token"),
//          let tokenString = String(data: tokenData, encoding: .utf8) else {
//      return
//    }
//    token = tokenString
//  }
//
//  func validateToken(handler: @escaping (Result<Bool, ErrorHandlingDomain>) -> ()) {
//    guard let token = token else {
//      handler(.failure(.noTokenParsed))
//      return
//    }
//    networkEngine.getCurrentUser(with: token) {[weak self] result in
//      switch result {
//      case .failure(_):
//        handler(.failure(ErrorHandlingDomain.tokenExpired))
//      case .success(let user):
//        self?.currentUser = user
//        self?.isTokenValid = true
//        handler(.success(true))
//      }
//    }
//  }
//
//  func loadCurrentUser(with token: String, handler: @escaping (Result<User?, ErrorHandlingDomain>) -> ()) {
//    networkEngine.getCurrentUser(with: token) {[weak self] result in
//      switch result {
//      case .failure(let error):
//        handler(.failure(error))
//      case .success(let user):
//        self?.currentUser = user
//        self?.isTokenValid = true
//        handler(.success(user))
//      }
//    }
//  }
//
//  func getToken(login: String, password: String, handler: @escaping (Result<Bool, ErrorHandlingDomain>) -> ())  {
//    networkEngine.loginToServer(login: login, password: password) {[weak self] result in
//      switch result {
//      case .failure(let error):
//        handler(.failure(error))
//      case .success(let token):
//        self?.token = token
//        guard let token = token else {
//          handler(.failure(ErrorHandlingDomain.noTokenParsed))
//          return
//        }
//        KeyChainService.save(key: "token", data: (token.data(using: .utf8)!))
//        self?.loadCurrentUser(with: token) {result in
//          switch result {
//          case .failure(let error):
//            handler(.failure(error))
//          case .success(let user):
//            self?.currentUser = user
//            handler(.success(true))
//          }
//        }
//      }
//    }
//  }
//}
