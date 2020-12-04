//
//  User.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 04.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

struct User: Codable {
  var id, username, fullName, avatar: String
  var currentUserFollowsThisUser, currentUserIsFollowedByThisUser: Bool
  var followsCount, followedByCount: Int
}
