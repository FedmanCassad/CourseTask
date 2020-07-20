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
  var profile: User?
  
  //MARK: - Lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    guard let profile = profile else {return}
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
 
}
