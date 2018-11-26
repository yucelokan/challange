//
//  Results.swift
//
//  Created by Okan Yücel on 26.11.2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Results: Base {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let kazanilanPara = "kazanilanPara"
    static let kazananlar = "kazananlar"
  }

  // MARK: Properties
  public var kazanilanPara: String?
  public var kazananlar: [String]?


  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public override func mapping(map: Map) {
    super.mapping(map: map)
    kazanilanPara <- map[SerializationKeys.kazanilanPara]
    kazananlar <- map[SerializationKeys.kazananlar]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public override func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = kazanilanPara { dictionary[SerializationKeys.kazanilanPara] = value }
    if let value = kazananlar { dictionary[SerializationKeys.kazananlar] = value }
    return dictionary
  }

}
