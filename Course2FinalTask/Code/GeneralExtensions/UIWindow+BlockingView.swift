//
//  UIWindow+BlockingView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 11.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
extension UIWindow {
  
  func lockTheView() {
    let lockView = ActivityIndicator()
    addSubview(lockView)
  }
  
  func unlockTheView() {
    subviews.forEach {
      if $0 is ActivityIndicator {
        $0.removeFromSuperview()
      }
    }
  }
  
}
