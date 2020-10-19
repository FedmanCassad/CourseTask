//
//  FistCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 11.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider
class HeaderView: UICollectionReusableView {
  var user: User! {
    willSet {
      guard let currentUser = currentUser else {return}
      if newValue.id == currentUser.id {
        self.folllowOrUnfollowButton.isHidden = true
        followingsLabel.text = "Followings \(currentUser.followsCount)"
      }
      else {
        self.folllowOrUnfollowButton.isHidden = false
        if newValue.currentUserFollowsThisUser {
          self.folllowOrUnfollowButton.setTitle("Unfollow", for: .normal)
          self.folllowOrUnfollowButton.sizeToFit()
          self.folllowOrUnfollowButton.frame.size.width = self.folllowOrUnfollowButton.intrinsicContentSize.width + 10
          
          self.folllowOrUnfollowButton.frame.origin.x -= self.folllowOrUnfollowButton.frame.width
          self.addSubview(self.folllowOrUnfollowButton)}
        else {
          self.folllowOrUnfollowButton.setTitle("Follow", for: .normal)
          self.folllowOrUnfollowButton.sizeToFit()
          self.folllowOrUnfollowButton.frame.size.width = self.folllowOrUnfollowButton.intrinsicContentSize.width + 10
          self.folllowOrUnfollowButton.frame.origin.x -= self.folllowOrUnfollowButton.frame.width
          self.addSubview(self.folllowOrUnfollowButton)
        }
      }
      
    }
    
    
  }
  
  var delegate: FeedCellDelegate?
  
  lazy var avatar: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()
  
  lazy var fullNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14)
    lbl.textColor = .black
    lbl.numberOfLines = 1
    return lbl
  }()
  
  lazy var followersLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.textColor = .black
    let tchRcg = UITapGestureRecognizer(target: self, action: #selector(goToFollowersListView))
    lbl.addGestureRecognizer(tchRcg)
    lbl.gestureRecognizers?[0].name = "followersTapped"
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  lazy var followingsLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    lbl.textColor = .black
    let tchRcg = UITapGestureRecognizer(target: self, action: #selector(goToFollowsListView))
    lbl.addGestureRecognizer(tchRcg)
    lbl.gestureRecognizers?[0].name = "followingsTapped"
    lbl.isUserInteractionEnabled = true
    return lbl
  }()
  
  lazy var folllowOrUnfollowButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 5
    button.backgroundColor = .systemBlue
    button.tintColor = .white
    let gr = UITapGestureRecognizer(target: self, action: #selector(followUnfollow))
    button.addGestureRecognizer(gr)
    button.isUserInteractionEnabled = true
    return button
  }()
  
  func configure (user: User) {
    self.user = user
    avatar.image = user.avatar
    fullNameLabel.text = user.fullName
    followersLabel.text = "Followers: \(user.followedByCount)"
    followingsLabel.text = "Followings: \(user.followsCount)"
    configureLayout()
  }
  
  
  private func configureLayout() {
    avatar.frame = CGRect(x: 8,
                          y: 8,
                          width: 70,
                          height: 70)
    avatar.clipsToBounds = true
    avatar.layer.cornerRadius = 35
    fullNameLabel.sizeToFit()
    fullNameLabel.frame.origin = CGPoint(x: avatar.layer.frame.maxX + 8,
                                         y: 8)
    followersLabel.sizeToFit()
    followingsLabel.sizeToFit()
    frame.size.height = avatar.frame.maxY
    followersLabel.frame.origin = CGPoint(x: avatar.frame.maxX + 8, y: frame.maxY - 8 - followersLabel.frame.height)
    followingsLabel.center.y = followersLabel.center.y
    followingsLabel.frame.origin.x = frame.maxX - 16 - followingsLabel.frame.width
    
    folllowOrUnfollowButton.frame.origin.x = frame.maxX - 25 - folllowOrUnfollowButton.frame.width
    folllowOrUnfollowButton.frame.origin.y = fullNameLabel.frame.minY
    
    addSubview(avatar)
    addSubview(fullNameLabel)
    addSubview(followersLabel)
    addSubview(followingsLabel)
  }
  
  //MARK: - Actions
  
  
  @objc func goToFollowersListView() {
    UIApplication.shared.keyWindow?.lockTheView()
    DataProviders.shared.usersDataProvider.usersFollowingUser(with: user.id, queue: .global(qos: .userInitiated)) {[weak self] users in
      guard let self = self else {return}
      guard let users = users  else {
        if let vc = self.delegate as? ProfileViewController {
          vc.alert(completion: nil)
        }
        return}
      DispatchQueue.main.async {
        self.delegate?.goToProfilesList(users: users, user: self.user, .followers)
      }
    }
  }
  
  
  @objc func goToFollowsListView() {
    UIApplication.shared.keyWindow?.lockTheView()
    DataProviders.shared.usersDataProvider.usersFollowedByUser(with: user.id, queue: .global(qos: .userInitiated)) {[weak self] users in
      guard let self = self else {return}
      guard let users = users else {
        if let vc = self.delegate as? ProfileViewController {
          vc.alert(completion: nil)
        }
        return}
      DispatchQueue.main.async {
        self.delegate?.goToProfilesList(users: users, user: self.user, .follows)
      }
    }
  }
  
  @objc func followUnfollow () {
    UIApplication.shared.keyWindow?.lockTheView()
    if !user.currentUserFollowsThisUser {
    DataProviders.shared.usersDataProvider.follow(user.id, queue:.global(qos: .userInteractive)){[weak self] recievedUser in
      guard let self = self else {return}
      guard let user = recievedUser else {
        if let vc = self.delegate as? ProfileViewController {
          vc.alert(completion: nil)
        }
        return
      }
      DataProviders.shared.usersDataProvider.currentUser(queue: .global(qos: .userInteractive)) {user in
        guard let user = user else {return}
        currentUser = user
      }
      
      DispatchQueue.main.async {
        self.configure(user: user)
        UIApplication.shared.keyWindow?.unlockTheView()
      }
      }}
    else {
      DataProviders.shared.usersDataProvider.unfollow(user.id, queue:.global(qos: .userInteractive)){[weak self] recievedUser in
      guard let self = self else {return}
      guard let user = recievedUser else {
        if let vc = self.delegate as? ProfileViewController {
          vc.alert(completion: nil)
        }
        return
      }
        DataProviders.shared.usersDataProvider.currentUser(queue: .global(qos: .userInteractive)) {user in
          guard let user = user else {return}
          currentUser = user
        }
      DispatchQueue.main.async {
        self.configure(user: user)
        UIApplication.shared.keyWindow?.unlockTheView()
      }
      }}
    }
  }
  





