//
//  FilterCellDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.


import UIKit

protocol FilterCellDelegate {
  func applyFilter(_ filteredImage: UIImage?)
  func sizeForThumbnailImage() -> CGSize
}
