//
//  ProfileViewController + CollectionDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 21.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
extension ProfileViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let profile = profile else {return 1}
    var posts = Array<Post>()
    
    DataProviders.shared.postsDataProvider.findPosts(by: profile.id, queue: .global(qos: .userInteractive), handler: {optPosts in
      guard let recievedPosts = optPosts else {
        posts = Array<Post>()
        return}
      posts = recievedPosts
      
    })
    
    
    
    
    
    return posts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotosCell", for: indexPath) as! ProfilePhotosCell
    guard let profile = profile else {return cell}
    let dispatchGroup = DispatchGroup()
//    dispatchGroup.enter()
   
    DataProviders.shared.postsDataProvider.findPosts(by: profile.id, queue: .global(qos: .userInteractive)) {optPosts in
      if let recievedPosts = optPosts {
       
        let post = recievedPosts[indexPath.item]
        DispatchQueue.main.async {
              cell.configure(post: post)
//          dispatchGroup.leave()
        }
      }
    }
//    dispatchGroup.wait()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      
      let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
      
      guard let profile = self.profile else {return cell}
      cell.configure(user: profile)
      cell.delegate = self
      return cell
    }
    else {
      fatalError("Invalid view type")
    }
  }
  
}
