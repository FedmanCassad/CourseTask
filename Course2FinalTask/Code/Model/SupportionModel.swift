//
//  SupportionModel.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 21.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//
import UIKit

enum DestinationMeaning {
  case followers
  case follows
}

enum DataError: Error {
  case noDataRecieved
  case noTokenParsed
  case requestError(errorCode: HTTPURLResponse)
  case parsingFailed
  var localizedDescription: String {
    switch self {
      case
        .noDataRecieved:
        return "Data task cannot retrieve the data piece"
      case .noTokenParsed:
        return "Cannot get token from recieved data"
      case .requestError:
        return "Something wrong with performed request"
      case .parsingFailed:
        return "Failed to decode recieved data"
    }
  }
  
}
