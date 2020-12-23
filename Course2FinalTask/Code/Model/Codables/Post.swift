//
//  Feed.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

struct Post: Codable {
  var id, description, createdTime, author, authorUsername : String
  var image, authorAvatar: URL
  var currentUserLikesThisPost: Bool
  var likedByCount: Int    
}
