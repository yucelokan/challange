//
//  UserInformation.swift
//
//  Created by Okan Yücel on 26.11.2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class UserInformation: Base {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let name = "name"
    static let wildCardCount = "wildCardCount"
  }

  // MARK: Properties
  public var id: String?
  public var name: String?
  public var wildCardCount: Int?


  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
    public override func mapping(map: Map) {
    super.mapping(map: map)
    id <- map[SerializationKeys.id]
    name <- map[SerializationKeys.name]
    wildCardCount <- map[SerializationKeys.wildCardCount]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
    public override func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = wildCardCount { dictionary[SerializationKeys.wildCardCount] = value }
    return dictionary
  }

}
