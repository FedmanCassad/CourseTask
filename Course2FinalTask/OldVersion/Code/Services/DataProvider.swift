//
//  DataProvider.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 09.05.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

//import Foundation
//protocol FeedInterface {
//  func getFeed(handler: @escaping (Result<[Post], ErrorHandlingDomain>) -> ())
//}
//public enum Mode {
//  case offline,online
//}
//
//class DataProvider: NSObject {
//  let onlineProvider = NetworkEngine.shared
//  let offlineProvider: OfflineCacher
//  var cellProvider: PostCellProviderInterface!
//  var mode: Mode
//
//  init(offlineProviderModelName: String, mode: Mode) {
//    self.mode = mode
//    offlineProvider = CoreDataService(modelName: offlineProviderModelName)
//  }
//
//  private func constructPredicate(for key: String, value: Any) {
//
//  }
//}
//
//extension DataProvider: FeedInterface {
//  func getFeed(handler: @escaping (Result<[Post], ErrorHandlingDomain>) -> ()) {
//    if mode == .offline {
//
//    }
//  }
//}
//
//class SearchPredicateConstructor {
//  func getPredicates(by fields: [String: Any]) -> [NSPredicate] {
//    var predicates = [NSPredicate]()
//    for (key, value) in fields where key != "comparisonSign" {
//      if let value = value as? Bool {
//        let predicate = NSPredicate(format: "\(key) == %@", NSNumber(booleanLiteral: value))
//        predicates.append(predicate)
//      }
//      if let value = value as? String {
//        if let value = Int16(value), let sign = fields["comparisonSign"] as? String  {
//          let predicate = NSPredicate(format: "\(key) \(sign) %i", value)
//          predicates.append(predicate)
//        }
//        else {
//          let predicate = NSPredicate(format: "\(key) CONTAINS[c] %@", value)
//          predicates.append(predicate)
//        }
//      }
//    }
//    return predicates
//  }
//}
