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
  
  private func constructRequest<T>(for target: Target<T>) -> URLRequest? {
    var request = URLRequest(url: target.url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    if let token = token {
      request.setValue(token, forHTTPHeaderField: "token")
    }
    switch target {
      case .feed:
        return request
      case .getCurrentUser:
        return request
      case let .signIn(_, login, password):
        let parameters = [
          "login": login,
          "password": password
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
      case .findPosts:
        return request
      case .userFollowed:
        return request
      case .userFollowings:
        return request
      case .follow(_, let id):
        let parameters = [
          "userID": id
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
      case .unfollow(_, let id):
        let parameters = [
          "userID": id
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
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
        return request
      case .usersLikesSpecificPost:
        return request
      case let .likePost(_, postId):
        let parameters = [
          "postID": postId
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
      case let .unlikePost(_, postID):
        let parameters = [
          "postID": postID
        ]
        request.httpMethod = HTTPMethod.POST.strigifiedMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
      case .signOut:
        return request
    }
    return request
  }
  
  
  func performRequest<T: Decodable>(for target: Target<T.Type>, completion: @escaping (Result<T?, DataError>) -> Void) {
    guard let request = constructRequest(for: target) else
    { return }
    let session = getURLSession()
    session.dataTask(with: request) { [self] (data, response, error) in
      if error != nil {
        if let response = response as? HTTPURLResponse {
              completion(.failure(.requestError(errorCode: response)))
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
        case .userFollowings:
          if let users = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(users))
          }
        case .userFollowed:
          if let users = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(users))
          }
        case .follow:
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))} else {
              completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
            }
        case .unfollow:
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
        case .getUser:
          if let user = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(user))} else {
              completion(.failure(.parsingFailed))
            }
        case .usersLikesSpecificPost:
          if let users = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(users))
          } else {
            completion(.failure(.parsingFailed))
          }
        case .likePost:
          if let post = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(post))
          } else {
            completion(.failure(.parsingFailed))
          }
        case .unlikePost:
          if let post = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(post))
          } else {
            completion(.failure(.parsingFailed))
          }
        case .signOut:
          completion(.success(true as? T))
      }
    }.resume()
  }
  
  //MARK: - Performing login request, if succesful - load feed.
  func loginAndMoveToFeed(login: String, password: String) {
    performRequest(for: .signIn(Bool.self, login: login, password: password)) { result in
      switch result {
        case let .failure(error):
          print(error.description)
          return
        case .success(_):
          NetworkEngine.shared.performRequest(for: .feed([Post].self)) { result in
            switch result {
              case let .failure(error):
                print(error.description)
                return
              case let .success(feed):
                if let feed = feed {
                  NetworkEngine.shared.runInMainQueue { [self] in
                    performRequest(for: .getCurrentUser(User.self)) {result in
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
  func findPosts(by: String, handler: @escaping (Result<[Post]?, DataError>) -> ()) {
    performRequest(for: .findPosts([Post].self, by)) {result in
      switch result {
        case let .failure(error):
          handler(.failure(error))
        case let .success(posts):
          handler(.success(posts))
      }
    }
  }
  
  //MARK: - Find followers
  func usersFollowingUser(with userID: String, handler: @escaping (Result<[User]?, DataError>) -> ()) {
    performRequest(for: .userFollowed([User].self, userID)) {result in
      switch result {
        case let .failure(error):
          handler(.failure(error))
        case let .success(users):
          handler(.success(users))
      }
    }
  }
  
  //MARK: - Find followings
  func usersFollowedByUser(with userID: String, handler: @escaping (Result<[User]?, DataError>) -> ()) {
    performRequest(for: .userFollowings([User].self, userID)) {result in
      switch result {
        case let .failure(error):
          handler(.failure(error))
        case let .success(users):
          handler(.success(users))
      }
    }
  }
  //MARK: - Follow function
  func follow(with userID: String, handler: @escaping (Result<User?, DataError>) -> ()) {
    performRequest(for: .follow(User.self, userID)) {result in
      switch result {
        case let .failure(error):
          handler(.failure(error))
        case let .success(user):
          handler(.success(user))
      }
    }
  }
  
  //MARK: - Unfollow function
  func unfollow(with userID: String, handler: @escaping (Result<User?, DataError>) -> ()) {
    performRequest(for: .unfollow(User.self, userID)) {result in
      switch result {
        case let .failure(error):
        
          handler(.failure(error))
        case let .success(user):
          handler(.success(user))
      }
    }
  }
  
  //MARK: - Get current user
  func currentUser(handler: @escaping (Result<User?, DataError>) -> ()) {
    performRequest(for: .getCurrentUser(User.self)) {result in
      switch result {
        case let .failure(error):
          handler(.failure(error))
        case let .success(user):
          self.currentUser = user
          handler(.success(user))
      }
    }
  }
  
  //MARK: - Upload post
  func uploadPost(image: UIImage, description: String, handler: @escaping (Result<Post?, DataError>) -> ()) {
    performRequest(for: .uploadPost(Post.self, image: image, description: description)) {result in
      switch result {
        case .failure(let error):
          handler(.failure(error))
        case .success(let post):
          handler(.success(post))
      }
    }
  }
  
  //MARK: - Get user by id
  func getUser(id: String, handler: @escaping (Result<User?, DataError>) -> ()) {
    performRequest(for: .getUser(User.self, id)) { result in
      switch result {
        case let .success(user):
          handler(.success(user))
        case let .failure(error):
          handler(.failure(error))
      }
    }
  }
  
  //MARK: - Get users liked specific post
  func usersLikedSpecificPost(postID: String, handler: @escaping (Result<[User]?, DataError>) -> ()) {
    performRequest(for: .usersLikesSpecificPost([User].self, postID: postID)) {result in
      switch result {
        case let .success(users):
          handler(.success(users))
        case let .failure(error):
          handler(.failure(error))
      }
    }
  }
  
  //MARK: - Like post
  func likePost(postID: String, handler: @escaping (Result<Post?, DataError>) -> ()) {
    performRequest(for: .likePost(Post.self, postID: postID)) {result in
      switch result {
        case .failure(let error):
          handler(.failure(error))
        case .success(let post):
          handler(.success(post))
      }
    }
  }
  
  //MARK: - Unlike post
  func unlikePost(postID: String, handler: @escaping (Result<Post?, DataError>) -> ()) {
    performRequest(for: .unlikePost(Post.self, postID: postID)) {result in
      switch result {
        case .failure(let error):
          handler(.failure(error))
        case .success(let post):
          handler(.success(post))
      }
    }
  }
  
  //MARK: - Logout func
  func logOut() {
    performRequest(for: .signOut(Bool.self)) {_ in
          self.currentUser = nil
          self.token = nil
      }
    }
  
  private func getURLSession() -> URLSession {
    return URLSession(configuration: .default)
  }
  
}
