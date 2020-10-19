//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 11.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import  DataProvider

class ProfileViewController: UIViewController {
  
  
  
  
  var collectionView: UICollectionView!
  var profile: User
  {
    willSet {
      self.collectionView.reloadData()
  }
  }
  
  var posts: [Post]?
  var finisher: ((ProfileViewController)->())?
  
  init (user: User) {
    profile = user

    super.init(nibName: nil, bundle: nil)
    configure(user: user)
  }
  
  func configure(user: User) {
       let layout = UICollectionViewFlowLayout()
       collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
      profile = user
       navigationItem.title = profile.username
       view.addSubview(collectionView)
       collectionView.backgroundColor = .white
       collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.isScrollEnabled = true
       collectionView.clipsToBounds = true
       collectionView.register(ProfilePhotosCell.self, forCellWithReuseIdentifier: "ProfilePhotosCell")
       collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
  }
  
  convenience init(user: User, finisher: @escaping (ProfileViewController)->() )
  {
    self.init(user: user)
    self.finisher = finisher
    finisher(self)
  }
 
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard  let currentUser =  currentUser else {
      return
    }
    if profile.id == currentUser.id {
      if profile.followsCount != currentUser.followsCount {
        profile = currentUser
      }
    }
  }

  //MARK: - Lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}
