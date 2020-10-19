//
//  AddImageViewController+CollectionViewDataSource.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 17.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

extension AddImageViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageLibrary.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersFullSizeCell", for: indexPath) as!
     FiltersFullSizeCell
    cell.delegate = self
    cell.configureForPhotosLibrary(imageLibrary[indexPath.item])
    return cell
  }
  
}
