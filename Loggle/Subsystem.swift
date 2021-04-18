//
//  SubSytem.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
//

import Foundation

class Subsystem: Codable {

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
  case off = "off"
  case `default` = "default"
  case info = "info"
  case debug = "debug"
}

