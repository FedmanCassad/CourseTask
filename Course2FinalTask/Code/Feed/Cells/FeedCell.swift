//
//  TableViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 05.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UITableViewCell {
  var post: Post!
  var delegate: FeedCellDelegate?
  
  var doubleTapRecognizer: UITapGestureRecognizer {
    let tchRecg = UITapGestureRecognizer(target: self, action: #selector(userSomeHowTapped(sender:)))
    tchRecg.numberOfTapsRequired = 2
    tchRecg.numberOfTouchesRequired = 1
    return tchRecg
  }
  
  var singleTapRecognizer: UITapGestureRecognizer {
    let tchRecg = UITapGestureRecognizer(target: self, action: #selector(userSomeHowTapped(sender:)))
    tchRecg.numberOfTapsRequired = 1
    tchRecg.numberOfTouchesRequired = 1
    return tchRecg
  }
  
  
  
  //MARK: - Top footer (avatar,nickname,created time)
  private lazy var avatarImage: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.addGestureRecognizer(singleTapRecognizer)
    img.gestureRecognizers?[0].name = "avatarTapped"
    img.isUserInteractionEnabled = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private lazy var usersName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    lbl.addGestureRecognizer(singleTapRecognizer)
    lbl.gestureRecognizers?[0].name = "userNameTapped"
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  private lazy var timeStamp: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    return lbl
  }()
  
  //MARK: - Post picture
  
  private lazy var postImage: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    
    imgView.addGestureRecognizer(doubleTapRecognizer)
    imgView.gestureRecognizers?[0].name = "bigPictureDoubleTapped"
    imgView.isUserInteractionEnabled = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  //MARK: - Footer
  private lazy var likesLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.addGestureRecognizer(singleTapRecognizer)
    lbl.gestureRecognizers?[0].name = "listOfLikes"
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .custom)
    let img = UIImage(named: "like")
    button.setImage(img, for: .normal)
    button.tintColor = .lightGray
    button.sizeToFit()
    button.addGestureRecognizer(singleTapRecognizer)
    button.gestureRecognizers?[0].name = "likeTapped"
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var commentLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  private lazy var bigLike: UIImageView = {
    
    let img = UIImage(named: "bigLike")
    
    let imgView = UIImageView(image: img)
    
    imgView.tintColor = .white
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  
  func configure(with post: Post) {

      
    
    
    self.post = post
    //MARK: - Initialising UIs with post data
    frame.size.width = UIScreen.main.bounds.width
    clipsToBounds = true
    backgroundColor = .white
//    let avatarURL = URL(string: post.authorAvatar)

    avatarImage.kf.setImage(with: post.authorAvatar)
    postImage.kf.setImage(with: post.image)
       
    
    usersName.text = post.authorUsername
    let isoFormatter = ISO8601DateFormatter()
    guard let date = isoFormatter.date(from: post.createdTime) else {return}
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "GMT+3")
    let components = calendar.dateComponents([.day,.month, .year], from: date)
    let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date())
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
    let time = calendar.date(from: timeComponents)
    if components == nowComponents {
      formatter.dateStyle = .none
      timeStamp.text = "Today at \(formatter.string(from: time!))"
    } else {
      
      timeStamp.text = formatter.string(from: date)
    }
    

    
    
    likesLabel.text = "Likes: \(post.likedByCount)"
    commentLabel.text = post.description
    if post.currentUserLikesThisPost {
      likeButton.isSelected = true
      likeButton.tintColor = .systemBlue
    }
    configureLayout()
    
  }

  private func configureLayout () {
    commentLabel.sizeToFit()
    likesLabel.sizeToFit()
    usersName.sizeToFit()
    timeStamp.sizeToFit()

    //MARK: - Configuring layout by frames
    avatarImage.frame = CGRect(x: 15,
                               y: 8,
                               width: 35,
                               height: 35)
    usersName.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: 8)
    postImage.frame = CGRect(x: 0,
                             y: avatarImage.frame.maxY + 8,
                             width: frame.width,
                             height: frame.width)
    timeStamp.frame.origin = CGPoint(x: avatarImage.frame.maxX + 8,
                                     y: avatarImage.frame.maxY - timeStamp.frame.height)
    likesLabel.frame.origin = CGPoint(x: 15,
                                      y: 0)
    likesLabel.center.y = postImage.frame.maxY + 22
    likeButton.center.y = likesLabel.center.y
    likeButton.frame.origin.x = frame.maxX - likeButton.frame.width - 15
    commentLabel.frame = CGRect(x: 15, y: postImage.frame.maxY + 44, width: frame.width - 30, height: commentLabel.intrinsicContentSize.height)
    bigLike.center = postImage.center
    commentLabel.sizeToFit()
    addSubview(avatarImage)
    addSubview(usersName)
    addSubview(timeStamp)
    addSubview(postImage)
    addSubview(likesLabel)
    addSubview(likeButton)
    addSubview(commentLabel)
    contentView.frame.size.height = commentLabel.frame.maxY
  }
  
  //MARK: - Actions
  @objc func userSomeHowTapped(sender: UITapGestureRecognizer) {
//    switch sender.name {
//      case "bigPictureDoubleTapped":
//        animateLike()
//        likeTapped()
//      case "avatarTapped":
//        goToProfile()
//      case "userNameTapped":
//        goToProfile()
//      case "likeTapped":
//        likeTapped()
//      case "listOfLikes":
//        goToListView()
//      default:
//        return
//    }
  }
  
  func animateLike() {
    bigLike.layer.opacity = 0
    addSubview(bigLike)
    let animator = CAKeyframeAnimation(keyPath: "opacity")
    animator.values = [0,1,1,0]
    animator.keyTimes  = [0, 0.1, 0.2, 0.3]
    animator.duration = 9
    animator.isAdditive = true
    animator.timingFunction = CAMediaTimingFunction(controlPoints: 0.15, 1, 0.85, 0)
    bigLike.layer.add(animator, forKey: "opacity")
  }
  
  func goToListView() {
//    UIApplication.shared.keyWindow?.lockTheView()
//    DataProviders.shared.postsDataProvider.usersLikedPost(with: post.id, queue: .global(qos: .userInteractive)){[weak self] optUIDs in
//      guard let self = self else {return}
//      guard let userIds = optUIDs else {
//        if let vc = self.delegate as? FeedTableViewController {
//          vc.alert(completion: nil)
//        }
//        return}
//      var users = Array<User>()
//      
//      userIds.forEach {[weak self] userID in
//        guard let self = self else {return}
//        DataProviders.shared.usersDataProvider.user(with: userID.id, queue: .global(qos: .userInteractive)){user in
//          guard let user = user  else {
//            if let vc = self.delegate as? FeedTableViewController {
//              vc.alert(completion: nil)
//            }
//            return}
//          users.append(user)
//        }
//      }
//      DataProviders.shared.usersDataProvider.user(with: self.post.author, queue: .global(qos: .userInteractive)){user in
//        guard let user = user else {
//          if let vc = self.delegate as? FeedTableViewController {
//            vc.alert(completion: nil)
//          }
//          return
//        }
//        DispatchQueue.main.async {
//          self.delegate?.goToProfilesList(users: users, user: user, .follows)
//        }
//      }
//    }
  }
  
  func goToProfile() {
//    UIApplication.shared.keyWindow?.lockTheView()
//    DataProviders.shared.usersDataProvider.user(with: post.author, queue: .global(qos: .userInteractive )){[weak self] user in
//      guard let self = self else {return}
//      guard let user = user else {
//        if let vc = self.delegate as? FeedTableViewController {
//          vc.alert(completion: nil)
//        }
//        return}
//      DispatchQueue.main.async {
//        self.delegate?.goToSelectedProfile(user: user)
//        UIApplication.shared.keyWindow?.unlockTheView()
//      }
//    }
//
//  }
//
//  func likeTapped() {
//    if !likeButton.isSelected {
//      likeButton.isSelected = true
//      likeButton.tintColor = .systemBlue
//      let group = DispatchGroup()
//      group.enter()
//      DataProviders.shared.postsDataProvider.likePost(with: post.id, queue: .global(qos: .userInteractive)){[weak self] post in
//        guard let self = self else {return}
//        guard  let receivedPost = post else {
//          if let vc = self.delegate as? FeedTableViewController {
//            vc.alert(completion: nil)
//          }
//          return
//        }
//        self.post = receivedPost
//        self.post.currentUserLikesThisPost = true
//        group.leave()
//        group.wait()
//        DispatchQueue.main.async {
//          self.likesLabel.text = "Likes: \(self.post.likedByCount)"
//          self.likesLabel.sizeToFit()
//        }
//      }
//    } else {
//      likeButton.isSelected = false
//      likeButton.tintColor = .lightGray
//      DataProviders.shared.postsDataProvider.unlikePost(with: post.id, queue: .global(qos: .userInteractive)) {[weak self] receivedPost in
//        guard let self = self else {return}
//        guard let updatePost = receivedPost else {
//          if let vc = self.delegate as? FeedTableViewController {
//            vc.alert(completion: nil)
//          }
//          return
//        }
//        self.post = updatePost
//        self.post.currentUserLikesThisPost = false
//        DispatchQueue.main.async {
//          self.likesLabel.text = "Likes: \(self.post.likedByCount)"
//          self.likesLabel.sizeToFit()
//        }
//      }
//    }
  }
 
  
}



