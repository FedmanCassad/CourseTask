////
////  FiltersFullSizeCell.swift
////  Course2FinalTask
////
////  Created by Vladimir Banushkin on 17.10.2020.
////  Copyright © 2020 e-Legion. All rights reserved.
////
//import UIKit
//import DataProvider
//
//class FiltersFullSizeCell: ProfilePhotosCell {
//  private lazy var imageView: UIImageView = {
//    let imageView = UIImageView()
//    return imageView
//  }()
//  
//  private lazy var gestureRecognizer: UITapGestureRecognizer = {
//    let gr = UITapGestureRecognizer(target: self, action: #selector(goToFiltersSelection))
//    return gr
//  }()
//  
//  var delegate: FiltersFullSizeCellDelegate?
//  
//  func configureForPhotosLibrary(_ image: UIImage) {
//    imageView.image = image
//    contentView.clipsToBounds = true
//    imageView.frame.size = CGSize(width: UIScreen.main.bounds.width/3-1,
//                                  height: 0)
//    imageView.frame.size.height = imageView.frame.width
//    imageView.contentMode = .scaleAspectFill
//    contentView.frame = imageView.bounds
//    contentView.addSubview(imageView)
//    imageView.addGestureRecognizer(gestureRecognizer)
//    imageView.isUserInteractionEnabled = true
//  }
//  
//  @objc func goToFiltersSelection() {
//    guard let image = imageView.image else {return}
//    delegate?.goToFiltersViewController(image: image)
//  }
//
//}
