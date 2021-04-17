//
//  FileManager+Extensions.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import Foundation

extension FileManager {
  func urls(at url: URL, skipsHiddenFiles: Bool = true, type: String) -> [URL] {
    guard let fileURLs = try? contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] ) else {
      return []
    }
    let filtered = fileURLs.filter{ $0.pathExtension == type }
    let sorted = filtered.sorted {
      $0.path < $1.path
    }
    return sorted
  }
}
