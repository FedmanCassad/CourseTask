//
//  ActivityIndicatorController.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 03.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {
  var indicator: UIActivityIndicatorView!
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    addLoader()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addLoader() {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.center = center
    addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
}
