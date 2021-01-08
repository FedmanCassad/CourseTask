//
//  FistCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 11.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
  var user: User! {
    willSet {
      guard let currentUser = NetworkEngine.shared.currentUser else {return}
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
  
  lazy var logOutButton: UIButton = {
    
    $0.setTitle("Log out", for: .normal)
    $0.frame.size.height = $0.intrinsicContentSize.height
    $0.frame.size.width = followingsLabel.frame.width
    $0.backgroundColor = UIViewController.hexStringToUIColor(hex: "#007AFF")
    $0.layer.cornerRadius = 5
    $0.setTitleColor(.white, for: .normal)
    $0.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    
    return $0
  }(UIButton())
  
  func configure (user: User) {
    self.user = user
    avatar.kf.setImage(with: URL(string: user.avatar)!)
    fullNameLabel.text = user.fullName
    followersLabel.text = "Followers: \(user.followedByCount)"
    followingsLabel.text = "Followings: \(user.followsCount)"
    configureLayout()
    logOutButton.isHidden =  user.id == NetworkEngine.shared.currentUser?.id ? false : true
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
    logOutButton.center.x = followingsLabel.center.x
    logOutButton.center.y = fullNameLabel.center.y + 10
    
    addSubview(avatar)
    addSubview(fullNameLabel)
    addSubview(followersLabel)
    addSubview(followingsLabel)
    addSubview(logOutButton)
  }
  
  //MARK: - Actions
  @objc func goToFollowersListView() {
    //     Router.window?.lockTheView()
    NetworkEngine.shared.usersFollowingUser(with: user.id) {[weak self] result in
      guard let self = self else {return}
      switch result {
        case .failure(let error):
          if let vc = self.delegate as? ProfileViewController {
            vc.alert(error: error)
          }
        case .success(let users):
          guard let users = users  else { return }
          DispatchQueue.main.async {
            self.delegate?.goToProfilesList(users: users, user: self.user, .followers)
          }
          
          
      }
    }
  }
  
  @objc func signOut() {
    Router.backToLoginView()
  }
  
  
  @objc func goToFollowsListView() {
    Router.window?.lockTheView()
    NetworkEngine.shared.usersFollowedByUser(with: user.id) {[weak self] result in
      guard let self = self else {return}
      switch result {
        case .failure(let error):
          if let vc = self.delegate as? ProfileViewController {
            vc.alert(error: error)
          }
        case .success(let users):
          
          guard let users = users else { return }
          DispatchQueue.main.async {
            self.delegate?.goToProfilesList(users: users, user: self.user, .follows)
          }
      }
    }
  }
  
  @objc func followUnfollow () {
    Router.window?.lockTheView()
    if !user.currentUserFollowsThisUser {
      NetworkEngine.shared.follow(with: user.id){[weak self] result in
        guard let self = self else {return}
        switch result {
          case .failure(let error):
            if let vc = self.delegate as? ProfileViewController{
              vc.alert(error: error)
            }
          case .success(let recievedUser):
            guard let user = recievedUser else { return }
            NetworkEngine.shared.currentUser {result in
              switch result {
                case .failure(let error):
                  if let vc = self.delegate as? ProfileViewController{
                    vc.alert(error: error)
                  }
                case .success(let user):
                  guard let user = user else {return}
                  NetworkEngine.shared.currentUser = user
              }
            }
            
            DispatchQueue.main.async {
              self.configure(user: user)
              Router.window?.unlockTheView()
            }
        }
      }
    }
    else {
      NetworkEngine.shared.unfollow(with: user.id){[weak self] result in
        guard let self = self else {return}
        switch result {
          case .failure(let error):
            if let vc = self.delegate as? ProfileViewController {
              vc.alert(error: error)
            }
          case .success(let recievedUser):
            guard let user = recievedUser else { return }
            DispatchQueue.main.async {
              self.configure(user: user)
              Router.window?.unlockTheView()
            }
            DispatchQueue.main.async {
              self.configure(user: user)
              Router.window?.unlockTheView()
            }
        }
      }
    }
  }
  
}






