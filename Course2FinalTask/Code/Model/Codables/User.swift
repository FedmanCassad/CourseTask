//
//  User.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 04.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

public struct User: Codable {
  var id, username, fullName, avatar: String
  var currentUserFollowsThisUser, currentUserIsFollowedByThisUser: Bool
  var followsCount, followedByCount: Int
  
  init() {
    id = ""
    username = ""
    fullName = ""
    avatar = ""
    currentUserFollowsThisUser = false
    currentUserIsFollowedByThisUser = false
    followsCount = 0
    followedByCount = 0
  }
  
}
