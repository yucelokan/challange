//
//  Answer.swift
//
//  Created by Okan Yücel on 26.11.2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Answer: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cevap = "cevap"
    static let dogruCevap = "dogruCevap"
  }

  // MARK: Properties
  public var cevap: Bool? = false
  public var dogruCevap: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    cevap <- map[SerializationKeys.cevap]
    dogruCevap <- map[SerializationKeys.dogruCevap]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.cevap] = cevap
    if let value = dogruCevap { dictionary[SerializationKeys.dogruCevap] = value }
    return dictionary
  }

}
