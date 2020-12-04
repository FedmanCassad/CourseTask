//
//  ChooseFilterViewController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class ChooseFilterViewController: UIViewController {
  
  lazy var mainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame.size.width = UIScreen.main.bounds.width
    imageView.frame.size.height = imageView.frame.width
    return imageView
  }()
  
  
  
  lazy var filterThumbinals: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    return collectionView
  }()
  
  var protectedImage: UIImage?
  let effectsKeys = ["CISepiaTone",
                     "CIColorInvert",
                     "CIGaussianBlur",
                     "CIVignette",
                     "CIPixellate",
                     "CITwirlDistortion"]
  
  init(_ image: UIImage) {
    super.init(nibName: nil, bundle: nil)
    mainImageView.image = image
    protectedImage = image
    view.addSubview(mainImageView)
    filterThumbinals.frame.size.height = view.frame.height - mainImageView.frame.height
    filterThumbinals.frame.origin = CGPoint(x: 0, y: mainImageView.frame.maxY)
    filterThumbinals.backgroundColor = .white
    view.addSubview(filterThumbinals)
    filterThumbinals.dataSource = self
    filterThumbinals.delegate = self
    filterThumbinals.isScrollEnabled = true
    filterThumbinals.clipsToBounds = true
    filterThumbinals.register(FiltersThumbinalCell.self, forCellWithReuseIdentifier: "FiltersThumbinalCell")
    title = "New post"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(goToSharePostVC))
  }
  
  override func viewWillLayoutSubviews() {
    filterThumbinals.frame.size.height -= tabBarController?.tabBar.frame.height ?? 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func goToSharePostVC() {
    guard let image = mainImageView.image else {return}
    let targetVC = SharePostViewController(image)
    self.navigationController?.pushViewController(targetVC, animated: true)
  }
  
}
