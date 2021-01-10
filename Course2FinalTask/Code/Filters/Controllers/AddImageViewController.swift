//
//  AddImageViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 15.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController {
  
  lazy var imageLibrary: [UIImage?]  = {
    var images = Array<UIImage?>()
    guard let filesCount = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil)?.count else { return [nil] }
          for i in 1...filesCount {
            let path = Bundle.main.path(forResource: "new\(i)", ofType: "jpg")
            images.append(UIImage(contentsOfFile: path!) ?? nil)
          }
    return images
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
