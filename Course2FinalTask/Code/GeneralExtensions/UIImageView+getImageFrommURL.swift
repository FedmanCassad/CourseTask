//
//  UIImageView+getImageFrommURL.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 20.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

  func getImage(fromURL url: URL) {
    self.kf.indicatorType = .activity
    self.kf.setImage(with: url)
  }

}
