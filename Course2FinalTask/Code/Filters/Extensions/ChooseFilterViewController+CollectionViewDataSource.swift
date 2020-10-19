//
//  ChooseFilterViewController+CollectionViewDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

extension ChooseFilterViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return effectsKeys.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersThumbinalCell", for: indexPath) as! FiltersThumbinalCell
    guard let image = protectedImage else {return cell}
    cell.configure(image: image, filterName: effectsKeys[indexPath.item])
    cell.delegate = self
    return cell
  }
  
}
