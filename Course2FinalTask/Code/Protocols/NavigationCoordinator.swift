//
//  NavigationCoordinator.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 13.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
protocol NavigationCoordinator: UITabBarDelegate {
  static func entryPoint(feed: [Post], currentUser: User) -> ()
}
