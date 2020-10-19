//
//  CollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 12.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfilePhotosCell: UICollectionViewCell {

  private lazy var image: UIImageView = {
    let imgView = UIImageView()
    return imgView
  }()
  
  final func configure(post: Post){
    contentView.clipsToBounds = true
    image.image = post.image
    image.frame.size = CGSize(width: UIScreen.main.bounds.width/3-1, height: 0 )
    image.frame.size.height = image.frame.width
    contentView.frame = image.bounds
    contentView.addSubview(image)
   
}
  
}
