//
//  Feed.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import CoreData

public class Post: NSManagedObject, Codable {
  var postid, postDescription, createdTime, author, authorUsername: String?
  var image, authorAvatar: URL?
  var currentUserLikesThisPost: Bool?
  var likedByCount: Int?
  var imageData, avatarImageData: Data?

  enum CodingKeys: String, CodingKey {
        case postid = "id"
    case postDescription = "description"
    case createdTime, author, authorUsername, image, authorAvatar, currentUserLikesThisPost, likedByCount, imageData, avatarImageData
    }
}
