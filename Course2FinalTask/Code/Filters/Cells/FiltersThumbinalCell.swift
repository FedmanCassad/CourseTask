//
//  FiltersThumbinalCell.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class FiltersThumbinalCell: UICollectionViewCell {
  private lazy var thumbinalImage: UIImageView = {
    return UIImageView()
  }()
  
  private lazy var filterLabel: UILabel = {
    return UILabel()
  }()
  
  private lazy var gestureRecognizer: UITapGestureRecognizer = {
    let gr = UITapGestureRecognizer(target: self, action: #selector(applyFilter))
    return gr
  }()
  
  var filteredImage: UIImage?
  let intensityConst = 0.5
  var delegate: FilterCellDelegate?
  
  func configure(image: UIImage, filterName: String){
    let queue = DispatchQueue(label: "Filtering", qos: .utility, attributes: .concurrent)
    self.thumbinalImage.frame.size = (delegate?.sizeForThumbinalImage())!
    self.thumbinalImage.contentMode = .scaleAspectFit
    self.thumbinalImage.center = self.contentView.center
    self.thumbinalImage.addGestureRecognizer(gestureRecognizer)
    self.thumbinalImage.isUserInteractionEnabled = true
    self.addSubview(self.thumbinalImage)
    self.filterLabel.text = filterName
    self.filterLabel.sizeToFit()
    self.filterLabel.center.x = self.thumbinalImage.center.x
    self.filterLabel.frame.origin.y = self.thumbinalImage.frame.maxY + 8
    self.addSubview(self.filterLabel)
    queue.async {[weak self] in
      guard let self = self else {return}
      let context = CIContext()
      guard let preparedImage = CIImage(image: image) else {return}
      let filter = CIFilter(name: filterName)
      guard let safeFilter = filter else {return}
      safeFilter.setValue(preparedImage, forKey: kCIInputImageKey)
      if safeFilter.inputKeys.contains(kCIInputIntensityKey){ safeFilter.setValue(self.intensityConst, forKey: kCIInputIntensityKey)}
      if safeFilter.inputKeys.contains(kCIInputRadiusKey) { safeFilter.setValue(self.intensityConst * 100, forKey: kCIInputRadiusKey) }
      if safeFilter.inputKeys.contains(kCIInputScaleKey) { safeFilter.setValue(self.intensityConst * 25, forKey: kCIInputScaleKey) }
      if safeFilter.inputKeys.contains(kCIInputCenterKey) { safeFilter.setValue(CIVector(x: image.size.width/2 , y: image.size.height/2), forKey: kCIInputCenterKey) }
      if let filteredImage = safeFilter.outputImage {
        if let resultingImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
          let imageToSet = UIImage(cgImage: resultingImage)
          DispatchQueue.main.async {
            self.thumbinalImage.image = imageToSet}
          self.filteredImage = imageToSet
        }
      }
    }
  }
  
  @objc func applyFilter() {
    delegate?.applyFilter(filteredImage)
  }
}
