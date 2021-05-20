//
//  CellProviderInterface.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 09.05.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit

protocol PostCellProviderInterface {
  func getPostId() -> String
  func getPostDescription() -> String
  func getPostCreatedTime() -> String
  func getPostAuthor() -> String
  func getPostAuthorUsername() -> String
  func getPostImage() -> UIImage

}
