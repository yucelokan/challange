//
//  Question.swift
//
//  Created by Okan Yücel on 26.11.2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Question: Base {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let soru = "soru"
    static let cevaplar = "cevaplar"
    static let dogruCevap = "dogruCevap"
    static let toplamSoru = "toplamSoru"
    static let soruSira = "soruSira"
  }

  // MARK: Properties
  public var soru: String?
  public var cevaplar: [String]?
  public var dogruCevap: String?
  public var toplamSoru: Int?
  public var soruSira: Int?


  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public override func mapping(map: Map) {
    super.mapping(map: map)
    soru <- map[SerializationKeys.soru]
    cevaplar <- map[SerializationKeys.cevaplar]
    dogruCevap <- map[SerializationKeys.dogruCevap]
    toplamSoru <- map[SerializationKeys.toplamSoru]
    soruSira <- map[SerializationKeys.soruSira]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public override func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = soru { dictionary[SerializationKeys.soru] = value }
    if let value = cevaplar { dictionary[SerializationKeys.cevaplar] = value }
    if let value = dogruCevap { dictionary[SerializationKeys.dogruCevap] = value }
    if let value = toplamSoru { dictionary[SerializationKeys.toplamSoru] = value }
    if let value = soruSira { dictionary[SerializationKeys.soruSira] = value }
    return dictionary
  }

}
