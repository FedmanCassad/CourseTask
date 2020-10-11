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
  var posts: [Post]?
  var finisher: ((ProfileViewController)->())?
  
  init (user: User) {
    profile = user

    super.init(nibName: nil, bundle: nil)
    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  //MARK: - Lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
