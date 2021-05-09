//
//  CoreDataService.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 09.05.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import CoreData
import UIKit

protocol OfflineCacher {
  func saveCodableUserToPersistentStore(user: User)
  func saveCodablePostToPersistentStore(post: Post)
}

class CoreDataService {
  let modelName: String

  init(modelName: String) {
    self.modelName = modelName
    print(container)
  }

  lazy private var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modelName)
    container.loadPersistentStores {description, error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
    return container
  }()

  func getContext() -> NSManagedObjectContext {
    return container.viewContext
  }

  func save() {
    let context = getContext()
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let error = error as NSError
        fatalError("Fatal error: \(error) \(error.userInfo)")
      }
    }
  }

  func createObject<T>(from entity: T.Type) -> T? {
    let context = getContext()
    guard let type = entity as? NSManagedObject.Type else { return nil }
    let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: type), into: context) as! T
    return object
  }

  func deleteObject<T: NSManagedObject> (object: T) {
    let context = getContext()
    context.delete(object)
    save()
  }

  private func fetchData<T: NSManagedObject> (for entity: T.Type, with predicate: NSPredicate? = nil) -> [T]? {
    let context = getContext()
    let request: NSFetchRequest<T>
    var fetchedResult = [T]()
    request = NSFetchRequest(entityName: String(describing: entity))
    request.predicate = predicate
    do  {
      fetchedResult = try context.fetch(request)
    } catch {
      debugPrint("Error occurred: \(error.localizedDescription)")
    }
    return fetchedResult
  }

}

extension CoreDataService: OfflineCacher {
  
  func saveCodableUserToPersistentStore(user: User) {
    let managedUser = createObject(from: ManagedUser.self)
    guard let url = URL(string: user.avatar) else {
      return
    }
    let imageData = UIImage(contentsOfFile: url.absoluteString)?.pngData()
    managedUser?.avatarImage = imageData
    managedUser?.currentUserFollowsThisUser = user.currentUserFollowsThisUser
    managedUser?.currentUserIsFollowedByThisUser = user.currentUserIsFollowedByThisUser
    managedUser?.followedByCount = Int16(user.followedByCount)
    managedUser?.followsCount = Int16(user.followsCount)
    managedUser?.id = user.id
    managedUser?.userName = user.username
    managedUser?.fullName = user.fullName
    save()
  }

  func saveCodablePostToPersistentStore(post: Post) {
    let managedPost = createObject(from: ManagedPost.self)
    let avatarImage = UIImage(contentsOfFile: post.authorAvatar.absoluteString)?.pngData()
    let postImage = UIImage(contentsOfFile: post.image.absoluteString)?.pngData()
    managedPost?.image = postImage
    managedPost?.authorAvatarImage = avatarImage
    managedPost?.id = post.postid
    managedPost?.postDescription = post.postDescription
    managedPost?.createdTime = post.createdTime
    managedPost?.author = post.author
    managedPost?.authorUsername = post.authorUsername
    managedPost?.currentUserLikesThisPost = post.currentUserLikesThisPost
    managedPost?.likedByCount = Int16(post.likedByCount)
    save()


  }

  func getFeed(for feedObject: inout [Post]) {
//    let managedFeed = fetchData(for: ManagedPost.self)
//    feedObject = managedFeed?.map {post in
//      guard let post = post  else { return }

    }
  }
