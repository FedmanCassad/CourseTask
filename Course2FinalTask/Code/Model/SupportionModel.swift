//
//  SupportionModel.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 21.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//
import UIKit

enum DestinationMeaning {
  case followers
  case follows
}

public enum DataError: Error {
  case noDataRecieved
  case noTokenParsed
  case requestError(errorCode: HTTPURLResponse)
  case parsingFailed
  var localizedDescription: String {
    switch self {
      case
        .noDataRecieved:
        return "Data task cannot retrieve the data piece"
      case .noTokenParsed:
        return "Cannot get token from recieved data"
      case .requestError:
        return "Something wrong with performed request"
      case .parsingFailed:
        return "Failed to decode recieved data"
    }
  }
}
  
  //MARK: - Enum for choosing resulting value
  /// Связный параметр используется для возврата нужного значения
  public enum Target<T> {
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
    case usersLikesSpecificPost(_ type: T, postID: String)
    case likePost(_ type: T, postID: String)
    case unlikePost(_ type: T, postID: String)
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
        case let .usersLikesSpecificPost(_, postID):
          return URL(string:"http://localhost:8080/posts/\(postID)/likes")!
        case .likePost:
          return URL(string:"http://localhost:8080/posts/like")!
        case .unlikePost:
          return URL(string:"http://localhost:8080/posts/unlike")!
      }
    }
    
  }
  

