//
//  Subsystem.swift
//  Loggle
//
//  Created by Chris Davis on 16/04/2021.
//

import Foundation

class Subsystem: Codable {
  
  let defaultOptionsKey = "DEFAULT-OPTIONS"
  
  var defaultKey: Category?
//
//  // TODO parsing unknown keys
//
//  //var categories: [String: [CategoryOptionKeys: EnableOptions]] = [: ]
//  enum CodingKeys: String, CodingKey {
//    case defaultKey = "DEFAULT-OPTIONS"
//  }
//
//  required init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    defaultKey = try container.decode(Category.self, forKey: .defaultKey)
//  }
  
}

class Category: Codable {
  var level: [CategoryOptionKeys.RawValue: EnableOptions.RawValue]?
  
  enum CodingKeys: String, CodingKey {
    case level = "Level"
  }
}

enum CategoryOptionKeys: String, Codable {
  case enable = "Enable"
  case persist = "Persist"
}

enum EnableOptions: String {
  case inherit = "Inherit"
  case `default` = "Default"
  case info = "info"
  case debug = "debug"
}

