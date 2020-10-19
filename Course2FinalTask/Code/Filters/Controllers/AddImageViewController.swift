//
//  AddImageViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 15.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class AddImageViewController: UIViewController {
  
  lazy var imageLibrary: [UIImage]  = {
    return DataProviders.shared.photoProvider.photos()
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    let layout = UICollectionViewFlowLayout()
    let filtersCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    filtersCollectionView.backgroundColor = .white
    view.addSubview(filtersCollectionView)
    filtersCollectionView.dataSource = self
    filtersCollectionView.delegate = self
    filtersCollectionView.isScrollEnabled = true
    filtersCollectionView.clipsToBounds = true
    filtersCollectionView.register(FiltersFullSizeCell.self, forCellWithReuseIdentifier: "FiltersFullSizeCell")
    title = "New post"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
