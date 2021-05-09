//
//  KeychainService.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 06.05.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import Security
import Foundation

class KeyChainService {
  static let server = "localhost"

  @discardableResult
  static func save(key: String, data: Data) -> OSStatus {
    let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                kSecAttrAccount as String: key,
                                kSecAttrServer as String: server,
                                kSecValueData as String: data]
    SecItemDelete(query as CFDictionary)
    return SecItemAdd(query as CFDictionary, nil)
  }

  @discardableResult
  static func delete(key: String) -> OSStatus {
    let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                kSecAttrAccount as String: key,
                                kSecAttrServer as String: server]
    return SecItemDelete(query as CFDictionary)
  }

  static func receive(key: String) -> Data? {
    let query = [
      kSecClass as String: kSecClassInternetPassword,
      kSecAttrAccount as String: key,
      kSecReturnData as String: kCFBooleanTrue!,
      kSecMatchLimit as String: kSecMatchLimitOne ] as [String : Any]
    var dataTypeRef: AnyObject? = nil
    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    if status == noErr {
      return dataTypeRef as! Data?
    } else {
      return nil
    }
  }
}
