//
//  FileManager+Extensions.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
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
