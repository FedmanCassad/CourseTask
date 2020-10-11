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
  var user: User!
  var delegate: CellDelegate?

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
    
    addSubview(avatar)
    addSubview(fullNameLabel)
    addSubview(followersLabel)
    addSubview(followingsLabel)
  }
  
  //MARK: - Actions

    
 @objc func goToFollowersListView() {
  DataProviders.shared.usersDataProvider.usersFollowingUser(with: user.id, queue: .global(qos: .userInitiated)) {[weak self] users in
    guard let users = users, let self = self else {return}
   DispatchQueue.main.async {
    self.delegate?.goToProfilesList(users: users, user: self.user, .followers)
    }
  }
  }
        
      
  @objc func goToFollowsListView() {
    DataProviders.shared.usersDataProvider.usersFollowedByUser(with: user.id, queue: .global(qos: .userInitiated)) {[weak self] users in
    guard let users = users, let self = self else {return}
      DispatchQueue.main.async {
      self.delegate?.goToProfilesList(users: users, user: self.user, .follows)
      }
    }
        
      
    }
    
    
    

  }


  

