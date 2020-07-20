//
//  Interfaces.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 12.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol CellDelegate {
  func goToSelectedProfile(user: User)
  func goToProfilesList(users: [User], _ meaning: DestinationMeaning)
}
