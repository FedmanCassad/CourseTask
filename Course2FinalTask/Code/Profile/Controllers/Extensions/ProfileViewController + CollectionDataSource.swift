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
  
      guard let posts = DataProviders.shared.postsDataProvider.findPosts(by: profile!.id)
        else {
          return 1}
  
      return posts.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotosCell", for: indexPath) as! ProfilePhotosCell
      let post = DataProviders.shared.postsDataProvider.findPosts(by: profile!.id)![indexPath.item]
      cell.configure(post: post)
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
