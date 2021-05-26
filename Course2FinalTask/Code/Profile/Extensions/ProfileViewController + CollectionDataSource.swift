//import UIKit
//
//extension ProfileViewController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    let group = DispatchGroup()
//    group.enter()
//    NetworkEngine.shared.findPosts(by: profile.id, handler: {[weak self] result in
//      guard let self = self else {return}
//      switch result {
//        case .failure(let error):
//          self.alert(error: error)
//        case .success(let optPosts):
//
//
//          guard let recievedPosts = optPosts else {
//            self.alert(error: .parsingFailed)
//            return}
//          self.posts = recievedPosts
//          group.leave()
//      }
//    })
//    group.wait()
//    if let posts = self.posts {
//      return posts.count
//    }
//    else {
//      return 0
//    }
//
//  }
//
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePhotosCell", for: indexPath) as! ProfilePhotosCell
//    if let posts = posts {
//      cell.configure(post: posts[indexPath.item])
//    }
//
//    return cell
//  }
//
//  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    if kind == UICollectionView.elementKindSectionHeader {
//
//      let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
//
//      cell.configure(user: profile)
//      cell.delegate = self
//      return cell
//    }
//    else {
//      fatalError("Invalid view type")
//    }
//  }
//}
