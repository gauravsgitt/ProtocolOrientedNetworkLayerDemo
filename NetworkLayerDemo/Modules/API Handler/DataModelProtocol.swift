//
//  DataModelProtocol.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

protocol DataModelProtocol {
  func decode<T: Codable>(dataDict: Any?, ofType: T.Type) -> T?
}

extension DataModelProtocol {
  func decode<T: Codable>(dataDict: Any?, ofType: T.Type) -> T? {
    if dataDict == nil { return nil }
    do {
      if let theJSONData = try? JSONSerialization.data(
        withJSONObject: dataDict as Any,
        options: []) {
        let decoder = JSONDecoder()
        let res = try decoder.decode(T.self, from: theJSONData)
        return res
      }
    } catch let parsingError {
      print("Error", parsingError)
    }
    return nil
  }
}
