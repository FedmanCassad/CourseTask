//
//  Feed.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

struct Post: Codable {
  var id, description, image, createdTime, author, authorUsername, authorAvatar: String
  var currentUserLikesThisPost: Bool
  var likedByCount: Int    
}
