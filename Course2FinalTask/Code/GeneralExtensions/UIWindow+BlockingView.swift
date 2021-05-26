//import UIKit
//
//extension UIWindow {
//
//  func lockTheView() {
//    let lockView = ActivityIndicator()
//    addSubview(lockView)
//  }
//  
//  func unlockTheView() {
//    subviews.forEach {subview in
//      if subview is ActivityIndicator {
//        DispatchQueue.main.async {[weak subview] in
//          subview?.removeFromSuperview()
//        }
//      }
//    }
//  }
//}
