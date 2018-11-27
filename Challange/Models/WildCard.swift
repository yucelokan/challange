//
//  WildCard.swift
//
//  Created by Okan Yücel on 26.11.2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WildCard: Base {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let kullanildi = "kullanildi"
    static let kalanWildCard = "kalanWildCard"
  }

  // MARK: Properties
  public var kullanildi: Bool? = false
  public var kalanWildCard: String?

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public override func mapping(map: Map) {
    super.mapping(map: map)
    kullanildi <- map[SerializationKeys.kullanildi]
    kalanWildCard <- map[SerializationKeys.kalanWildCard]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public override func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.kullanildi] = kullanildi
    if let value = kalanWildCard { dictionary[SerializationKeys.kalanWildCard] = value }
    return dictionary
  }

}
