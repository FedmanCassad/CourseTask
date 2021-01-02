//
//  Decoder.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 25.12.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class MyDecoder {
  
  enum DecoderType<T: Decodable> {
    case decode(_ type: T.Type)
    case serialize(_ type: T = [String: Any].self as! T)
  }
  
//  init() {  }
  func decode<T: Decodable>(decoderType: DecoderType<T>, jsonData: Data)  throws -> T where T: Decodable {
    switch decoderType {
      case .decode:
        if let result = try? JSONDecoder().decode(T.self, from: jsonData) {
          return result
        }
        else {
          throw DataError.parsingFailed
        }
      case .serialize:
        if let dict = try? JSONSerialization.jsonObject(with: jsonData) as? T {
          return dict
        }
        else {
          throw DataError.parsingFailed
        }
    }
  }
  
//  func getDecodable<T> (data: Data) -> T? {
//    let result = decode(decoderType: T, jsonData: data)
//    
//  }
  
}
