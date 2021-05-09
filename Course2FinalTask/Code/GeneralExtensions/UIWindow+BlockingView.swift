//
//  UIWindow+BlockingView.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 11.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//
//
import UIKit

extension UIWindow {

  func lockTheView() {
    let lockView = ActivityIndicator()
    addSubview(lockView)
  }
  
  func unlockTheView() {
    subviews.forEach {subview in
      if subview is ActivityIndicator {
        DispatchQueue.main.async {[weak subview] in
          subview?.removeFromSuperview()
        }
      }
    }
  }
}
