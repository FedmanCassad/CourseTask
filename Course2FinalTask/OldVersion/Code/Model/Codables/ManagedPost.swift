//
//  Feed.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 02.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import CoreData
public typealias Post = ManagedPost
public class ManagedPost: NSManagedObject, Codable {
  @NSManaged var postid, postDescription, createdTime, author, authorUsername: String?
  @NSManaged var image, authorAvatar: String?
  @NSManaged var currentUserLikesThisPost: Bool
  @NSManaged var likedByCount: Int16
  @NSManaged var imageData, avatarImageData: Data?

  enum CodingKeys: String, CodingKey {
    case postid = "id"
    case postDescription = "description"
    case createdTime, author, authorUsername, image, authorAvatar, currentUserLikesThisPost, likedByCount, imageData, avatarImageData
  }

  required convenience public init(from decoder: Decoder) throws {
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
          let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
          let entity = NSEntityDescription.entity(forEntityName: "ManagedPost", in: managedObjectContext)
    else {
      fatalError("Failed to decode Post")
    }
    self.init(entity: entity, insertInto: managedObjectContext)
    let container = try decoder.container(keyedBy: CodingKeys.self)
    author = try container.decodeIfPresent(String.self, forKey: .author)
    postid = try container.decodeIfPresent(String.self, forKey: .postid)
    postDescription = try container.decodeIfPresent(String.self, forKey: .postDescription)
    createdTime = try container.decodeIfPresent(String.self, forKey: .createdTime)
    authorUsername = try container.decodeIfPresent(String.self, forKey: .authorUsername)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    authorAvatar = try container.decodeIfPresent(String.self, forKey: .authorAvatar)
    currentUserLikesThisPost = try container.decodeIfPresent(Bool.self, forKey: .currentUserLikesThisPost)!
    likedByCount = try container.decodeIfPresent(Int16.self, forKey: .likedByCount)!
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(author, forKey: .author)
    try container.encode(postid, forKey: .postid)
    try container.encode(postDescription, forKey: .postDescription)
    try container.encode(createdTime, forKey: .createdTime)
    try container.encode(authorUsername, forKey: .authorUsername)
    try container.encode(image, forKey: .image)
    try container.encode(currentUserLikesThisPost, forKey: .currentUserLikesThisPost)
    try container.encode(likedByCount, forKey: .likedByCount)
    try container.encode(authorAvatar, forKey: .authorAvatar)
  }


}
