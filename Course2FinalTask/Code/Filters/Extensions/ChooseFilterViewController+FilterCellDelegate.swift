//
//  ChooseFilterViewController+FilterCellDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

extension ChooseFilterViewController: FilterCellDelegate {
  
  func applyFilter(_ filteredImage: UIImage?) {
    guard let safeImage = filteredImage else {return}
    mainImageView.image = safeImage
  }

}
