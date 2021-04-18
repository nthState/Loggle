//
//  AppEnvironment.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
//

import Foundation
import OSLog

class AppEnvironment: ObservableObject {
  
  let subsystemURL = URL(fileURLWithPath: "/Library/Preferences/Logging/Subsystems")
  
  @Published var subSystemURLs: [URL] = []
  
  @Published var map: [URL: [String: Category]] = [: ]
  
  init() {
    reload()
  }
  
  public func reload() {
    subSystemURLs = FileManager.default.urls(at: subsystemURL, type: "plist")

    subSystemURLs.forEach { (url) in
      map[url] = load(url: url)
    }
  }
  
}

extension AppEnvironment {
  
  private func load(url: URL) -> [String: Category] {
    
    var output: [String: Category] = [: ]
    do {
      let data = try Data(contentsOf: url)

      let decoder = PropertyListDecoder()
      output = try decoder.decode([String: Category].self, from: data)
      
    } catch {
      os_log("%{PUBLIC}@", log: OSLog.serialization, type: .error, "error: \(error)")
    }
    
    return output
  }
  
}

extension AppEnvironment {
  
  public func add(bundleId: String) {

    let script = String(format: """

    do shell script "sudo log config --mode 'level:%@' --subsystem %@ --category '%@'" with administrator privileges

    """, "debug", bundleId, "DEFAULT-OPTIONS")

    run(appleScript: script)
    
  }
  
}

extension AppEnvironment {
  
  public func add(category: String, to bundleId: String) {

    let script = String(format: """

    do shell script "sudo log config --mode 'level:%@' --subsystem %@ --category '%@'" with administrator privileges

    """, "debug", bundleId, category)

    run(appleScript: script)
    
  }
  
}

extension AppEnvironment {
  
  public func apply(url: URL, level: String, category: String) {

    let script = String(format: """

    do shell script "sudo log config --mode 'level:%@' --subsystem com.nthstate.Loggle --category '%@'" with administrator privileges

    """, level, category)

    run(appleScript: script)
    
  }
  
}

extension AppEnvironment {
  
  private func run(appleScript script: String) {
    guard let appleScript = NSAppleScript(source: script) else {
      return
    }
    var compileError: NSDictionary?
    appleScript.compileAndReturnError(&compileError)
    
    if let err = compileError {
      os_log("%{PUBLIC}@", log: OSLog.applescript, type: .error, "error: \(err)")
      return
    }
    
    var possibleError: NSDictionary?
    appleScript.executeAndReturnError(&possibleError)
    
    if let err = possibleError {
      os_log("%{PUBLIC}@", log: OSLog.applescript, type: .error, "error: \(err)")
      return
    }
  }
  
}

extension AppEnvironment {
  
  public func save(url: URL) {
    guard let item = map[url] else {
      return
    }
    
    var str: String?
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    do {
      let data = try encoder.encode(item)
      str = String(decoding: data, as: UTF8.self)
    } catch {
      os_log("%{PUBLIC}@", log: OSLog.serialization, type: .error, "error: \(error)")
    }
    
    guard let s = str else {
      return
    }
    
    let processedScript = s.replacingOccurrences(of: "\"", with: "\\\"")
    
    let fileName = url.lastPathComponent
    
    let script = String(format: """
    set fileName to "%@"
    set fileContents to quoted form of "%@"

    set subSystemPath to "/Library/Preferences/Logging/Subsystems/"
    set fullPath to subSystemPath & fileName

    do shell script "echo " & fileContents & " > " & fullPath with administrator privileges

    """, fileName, processedScript)

    run(appleScript: script)
    
  }
  
}
