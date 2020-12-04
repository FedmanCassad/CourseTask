//
//  NetworkiSingletonswift.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 01.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

class NetworkEngine {
  
  private var token: String?
  var currentUser: User?
  
  enum Hosts {
    case signIn
    case feed
    case getCurrentUser
    var stringifiedURL: String {
      switch self {
        case .feed:
          return "http://localhost:8080/posts/feed"
        case .signIn:
          return "http://localhost:8080/signin"
        case .getCurrentUser:
          return "http://localhost:8080/users/me"
      }
    }
  }
  
  static var shared: NetworkEngine = {
    let instance = NetworkEngine()
    return instance
  }()
  
  private init() {}
  
  func getCurrentUser() {
    guard let token = token else {
      print("Please perform login request first")
      return
    }
    guard let url = URL(string: Hosts.getCurrentUser.stringifiedURL) else {return}
    let session = getURLSession()
    var request = URLRequest(url: url)
    request.setValue(token, forHTTPHeaderField: "token")
    session.dataTask(with: request) {(data, response, error) in
      if let data = data {
        if let user = try? JSONDecoder().decode(User.self, from: data) {
          print(user)
        }
      }
      
    }
    
  }
  
  
  private func recieveFeed(result: @escaping (Result<[Post], DataError>) -> Void) {
    guard let url = URL(string: Hosts.feed.stringifiedURL) else
    {return}
    var request = URLRequest(url: url)
    request.setValue(token, forHTTPHeaderField: "token")
    let session = getURLSession()
    session.dataTask(with: request) {(data,response,error) in
      if let response = response {
        print(response.description)
      }
      if error != nil {
        result(.failure(.requestError))
      } else {
        guard let data = data else {
          result(.failure(DataError.noDataRecieved))
          return
        }
        if let feed = try? JSONDecoder().decode([Post].self, from: data){
          result(.success(feed))
        }
      }
    }.resume()
  }
  
  func loginAttemptAndGetFeed(login: String?, password: String?, result: @escaping (Result<[Post], DataError>) -> Void) {
    if token != nil {
      recieveFeed {resulting in
        switch resulting {
          case .failure(let error):
            result(.failure(error))
          case .success(let feed):
            result(.success(feed))
        }
      }
    } else {
      guard let login = login,
            let password = password else { return }
      loginRequest(login: login, password: password) {resulting in
        switch resulting {
          case .failure(let error):
            result(.failure(error))
          case .success(let isSuccesful):
            guard isSuccesful else {
              result(.failure(.noTokenParsed))
              return
            }
            self.recieveFeed {resulting in
              switch resulting {
                case .failure(let error):
                  result(.failure(error))
                case .success(let feed):
                  result(.success(feed))
              }
            }
        }
      }
    }
  }
  
  private func getURLSession() -> URLSession {
    return URLSession.shared
  }
  //MARK: - Login request
  private func loginRequest(login: String, password: String, completion: @escaping (Result<Bool,DataError>) -> Void ) {
    let parameters = [
      "login": login,
      "password": password
    ]
    
    print(parameters)
    guard let url = URL(string: Hosts.signIn.stringifiedURL) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    let session = getURLSession()
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    session.dataTask(with: request) {(data,response,error) in
      if error != nil {
        completion(.failure(.requestError))
      }
      guard let data = data else {
        completion(.failure(DataError.noDataRecieved))
        return
      }
      guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        completion(.failure(DataError.noTokenParsed))
        return
      }
      if let token = dict["token"] as? String {
        self.token = token
        completion(.success(true))
      } else {
        completion(.failure(DataError.noTokenParsed))
      }
    }.resume()
    
  }
  
}
