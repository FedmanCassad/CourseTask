//
//  NetworkiSingletonswift.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class NetworkEngine {
  
  var token: String?
  var currentUser: User?
  var tempUser: User?
  
  enum HTTPMethod {
    case GET, POST
    var strigifiedMethod: String {
      switch self {
        case .GET:
          return "GET"
        case .POST:
          return "POST"
      }
    }
  }
  
  //MARK: - Enum for choosing resulting value
  /// Связный параметр используется для возврата нужного значения
  enum Hosts<T> {
    case signIn(_ type: T, login: String, password: String)
    case feed(_ type: T)
    case getCurrentUser(_ type: T)
    case findPosts(_ type: T = [Post].self as! T,_ userID: String)
    case userFollowings(_ type: T,_ userID: String)
    case userFollowed(_ type: T,_ userID: String)
    case follow(_ type: T, _ userID: String)
    case unfollow(_ type: T,_ userID: String )
    case uploadPost(_ type: T, image: UIImage, description: String? )
    case getUser(_ type: T, _ userID: String)
    var url: URL {
      switch self {
        case .feed:
          return URL(string: "http://localhost:8080/posts/feed")!
        case .signIn:
          return URL(string: "http://localhost:8080/signin")!
        case .getCurrentUser:
          return URL(string: "http://localhost:8080/users/me")!
        case let .findPosts(_, id):
          return URL(string: "http://localhost:8080/users/\(id)/posts")!
        case let .userFollowings(_, id):
          return URL(string: "http://localhost:8080/users/\(id)/following")!
        case let .userFollowed(_, id):
          return URL(string: "http://localhost:8080/users/\(id)/followers")!
        case .follow:
          return URL(string: "http://localhost:8080/users/follow")!
        case .unfollow:
          return URL(string: "http://localhost:8080/users/unfollow")!
        case .uploadPost:
          return URL(string:"http://localhost:8080/posts/create")!
        case let .getUser( _, id):
          return URL(string: "http://localhost:8080/users/\(id)")!
          
      }
    }
  }
  
  /// Общий и единственный объект класса
  static var shared: NetworkEngine = {
    let instance = NetworkEngine()
    return instance
  }()
  
  private init() {}
  
  //MARK: - Just for fun
  private func runInMainQueue(block: @escaping () -> ()) {
    DispatchQueue.main.async {
      block()
    }
  }
  
  //MARK: - Request constructor
  /// Запросно-шаблонный генератор
  /// - Parameter target: Сюда приходит енамчик со связанным параметром, опредяляющим, что именно мы должны получить, правда в самом генераторе этот не нужно, но чтобы не лепить еще один параметр-сойдет.
  /// - Returns: Возвращается опциональный URLRequest(а вдруг не вышло собрать запрос)
  private func constructRequest<T>(whatYouWantToGet target: Hosts<T>) -> URLRequest? {
    var request = URLRequest(url: target.url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(token, forHTTPHeaderField: "token")
    switch target {
      case .feed:
        guard let token = token else { return nil }
        request.setValue(token, forHTTPHeaderField: "token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      case .getCurrentUser:
        guard let token = token else { return nil }
        request.setValue(token, forHTTPHeaderField: "token")
      case let .signIn(_, login, password):
        let parameters = [
          "login": login,
          "password": password
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      case .findPosts:
        guard let token = token else { return nil }
        request.setValue(token, forHTTPHeaderField: "token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(request.debugDescription)
      case .userFollowed:
        guard let token = token else
        {
          return nil
          
        }
        request.httpMethod = HTTPMethod.GET.strigifiedMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "token")
        print(request.debugDescription)
        print(token)
      case .userFollowings:
        guard let token = token else {
          return nil
        }
        request.httpMethod = "GET"
        print(token)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "token")
        print(request.debugDescription)
      case .follow(_, let id):
        request.setValue(token, forHTTPHeaderField: "token")
        let parameters = [
          "userID": id
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      case .unfollow(_, let id):
        request.setValue(token, forHTTPHeaderField: "token")
        let parameters = [
          "userID": id
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      case .uploadPost(_, let image, let description):
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        guard let imageData = image.jpegData(compressionQuality: 1)
        else { return nil}
        let base64ImageString = imageData.base64EncodedString()
        
        let data = [
          "image": base64ImageString,
          "description": description ?? ""
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: data)
      case .getUser:
        request.setValue(token, forHTTPHeaderField: "token")
        
    }
    return request
  }
  
  //MARK: - Generic request execution
  private func performRequest<T: Decodable>(whatYouWantToGet target: Hosts<T.Type>, completion: @escaping (Result<T?, DataError>) -> Void) {
    guard let request = constructRequest(whatYouWantToGet: target) else
    { return }
    let session = getURLSession()
    session.dataTask(with: request) { [self] (data, response, error) in
      if error != nil {
        completion(.failure(.noDataRecieved))
      }
      if let response = response as? HTTPURLResponse {
        switch response.statusCode {
          case 404:
            completion(.failure(.requestError(errorCode: response)))
          case 406:
            completion(.failure(.requestError(errorCode: response)))
          default:
            print(response.statusCode)
        }
      }
      guard let data = data else {
        completion(.failure(.noDataRecieved))
        return
      }
      switch target {
        case .feed:
          
          if let feed = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(feed))
          }
          else {
            completion(.failure(.parsingFailed))
          }
        case .getCurrentUser:
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))}
        case .signIn:
          guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            completion(.failure(DataError.noTokenParsed))
            return
          }
          if let token = dict["token"] as? String {
            self.token = token
            completion(.success(true as? T))
          }
        case .findPosts:
          if let posts = try? JSONDecoder().decode(T.self, from: data){
            completion(.success(posts))}
        case .userFollowings(_, _):
          if let users = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(users))
          }
        case .userFollowed(_, _):
          if let users = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(users))
          }
        case .follow(_, _):
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))} else {
              completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
            }
        case .unfollow(_, _):
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))} else {
              completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
            }
        case .uploadPost:
          if let post = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(post))
          } else {
            completion(.failure(.noDataRecieved))
          }
        case .getUser(_, _):
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))} else {
              completion(.failure(.parsingFailed))
            }
      }
    }.resume()
  }
  
  //MARK: - Performing login request, if succesful - load feed.
  public func loginAndMoveToFeed(login: String, password: String) {
    performRequest(whatYouWantToGet: .signIn(Bool.self, login: login, password: password)) {[self] result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
          return
        case .success(_):
          NetworkEngine.shared.performRequest(whatYouWantToGet: .feed([Post].self)) { [self] result in
            switch result {
              case let .failure(error):
                print(error.localizedDescription)
                return
              case let .success(feed):
                
                if let feed = feed {
                  NetworkEngine.shared.runInMainQueue {
                    performRequest(whatYouWantToGet: .getCurrentUser(User.self)) {result in
                      guard let user  = try? result.get() else { return }
                      currentUser = user
                      runInMainQueue {
                        
                        Router.entryPoint(feed: feed, currentUser: user)
                      }
                    }
                  }
                }
            }
          }
      }
    }
  }
  
  //MARK: - Find posts function
  func findPosts(by: String, handler: @escaping ([Post]?) -> ()) {
    performRequest(whatYouWantToGet: .findPosts([Post].self, by)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
        case let .success(posts):
          handler(posts)
      }
    }
  }
  
  //MARK: - Find followers
  func usersFollowingUser(with userID: String, handler: @escaping ([User]?) -> ()) {
    performRequest(whatYouWantToGet: .userFollowed([User].self, userID)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
        case let .success(users):
          handler(users)
      }
    }
  }
  //MARK: - Find followings
  func usersFollowedByUser(with userID: String, handler: @escaping ([User]?) -> ()) {
    performRequest(whatYouWantToGet: .userFollowings([User].self, userID)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
        case let .success(users):
          handler(users)
      }
    }
  }
  //MARK: - Follow function
  func follow(with userID: String, handler: @escaping (User?) -> ()) {
    performRequest(whatYouWantToGet: .follow(User.self, userID)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
          handler(nil)
        case let .success(user):
          handler(user)
      }
    }
  }
  
  //MARK: - Unfollow function
  func unfollow(with userID: String, handler: @escaping (User?) -> ()) {
    performRequest(whatYouWantToGet: .unfollow(User.self, userID)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
          handler(nil)
        case let .success(user):
          handler(user)
      }
    }
  }
  
  func currentUser(handler: @escaping (User?) -> ()) {
    performRequest(whatYouWantToGet: .getCurrentUser(User.self)) {result in
      switch result {
        case let .failure(error):
          print(error.localizedDescription)
          handler(nil)
        case let .success(user):
          self.currentUser = user
          handler(user)
      }
    }
  }
  
  func uploadPost(image: UIImage, description: String, handler: @escaping (Post?) -> ()) {
    performRequest(whatYouWantToGet: .uploadPost(Post.self, image: image, description: description)) {result in
      switch result {
        case .failure(let error):
          print(error.localizedDescription)
          handler(nil)
        case .success(let post):
          handler(post)
      }
    }
  }
  
  func getUser(id: String, handler: @escaping (User?) -> ()) {
    performRequest(whatYouWantToGet: .getUser(User.self, id)) { result in
      switch result {
        case let .success(user):
          handler(user)
        case let .failure(error):
          print(error.localizedDescription)
          handler(nil)
      }
    }
  }
  
  func logOut() {
    currentUser = nil
    token = nil
  }
  
  private func getURLSession() -> URLSession {
    return URLSession(configuration: .default)
  }
  
}
