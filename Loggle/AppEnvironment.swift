//
//  AppEnvironment.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import Foundation
import OSLog

class AppEnvironment: ObservableObject {
  
  let subsystemURL = URL(fileURLWithPath: "/Library/Preferences/Logging/Subsystems")
  
  @Published var subSystemURLs: [URL] = []
  
  @Published var map: [URL: [String: Category]] = [: ]
  
  init() {
    subSystemURLs = FileManager.default.urls(at: subsystemURL, type: "plist") ?? []

    subSystemURLs.forEach { (url) in
      map[url] = load(url: url)
    }
  }
  
  
}

extension AppEnvironment {
  
  func load(url: URL) -> [String: Category] {
    
    var output: [String: Category] = [: ]
    do {
      let data = try Data(contentsOf: url)
      //let str = String(decoding: data, as: UTF8.self)

      let decoder = PropertyListDecoder()
      output = try decoder.decode([String: Category].self, from: data)

      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "read")
    } catch {
      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(error)")
    }
    
    return output
  }
  
}

extension AppEnvironment {
  
  func save(url: URL) {
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
      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(error)")
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
    
//    set subSystemPath to "/Library/Preferences/Logging/Subsystems/"
//    set fullPath to subSystemPath & fileName
//
//    set subSystemPath to "/Library/Preferences/Logging/Subsystems/"
//    set fullPath to subSystemPath & fileName
//    #set fileContents to "%@"
//    #do shell script "echo " & quoted form of fileContents & " > " & fullPath with administrator privileges
    
    guard let appleScript = NSAppleScript(source: script) else {
      return
    }
    var compileError: NSDictionary?
    let success = appleScript.compileAndReturnError(&compileError)
    
    if let err = compileError {
      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(err)")
      return
    }
    
    var possibleError: NSDictionary?
    appleScript.executeAndReturnError(&possibleError)
    
    if let err = possibleError {
      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(err)")
      return
    }
    
  }
  
}
