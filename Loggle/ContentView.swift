//
//  ContentView.swift
//  Loggle
//
//  Created by Chris Davis on 16/04/2021.
//

import SwiftUI
import os.log

class Test: ObservableObject {
  
  
  func read() {
    let fileName = "com.hexr.hexr-app.plist"
    let url = URL(fileURLWithPath: "/Library/Preferences/Logging/Subsystems")
    let fileURL = url.appendingPathComponent(fileName)
    
    var str: String = ""
    do {
      let data = try Data(contentsOf: fileURL)
      str = String(decoding: data, as: UTF8.self)
      

      let decoder = PropertyListDecoder()
      let settings = try decoder.decode([String: Category].self, from: data)
      
     // let a = settings.defaultKey?.level

      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "read")
    } catch {
      os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(error)")
    }
    
    os_log("%{PUBLIC}@", log: OSLog.test, type: .debug, "str: \(str)")
  }
  
  func test() {
    
    
    let str = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>DEFAULT-OPTIONS</key>
        <dict>
            <key>Level</key>
            <dict>
                <key>Enable</key>
                <string>debug</string>
                <key>Persist</key>
                <string>debug</string>
            </dict>
        </dict>
        <key>Preview</key>
        <dict>
            <key>Level</key>
            <dict>
                <key>Enable</key>
                <string>Debug</string>
                <key>Persist</key>
                <string>Inherit</string>
            </dict>
        </dict>
    </dict>
    </plist>
    """
    
    let data = str.data(using: .utf8)
    
    let fileName = "com.nthstate.Loggle.plist"
    let url = URL(fileURLWithPath: "/Library/Preferences/Logging/Subsystems")
    //let fileURL = url.appendingPathComponent(fileName)
    
    
    
//    let savePanel = NSSavePanel()
//    savePanel.nameFieldStringValue = fileName
//    savePanel.directoryURL = url
//    //savePanel.fil
//    savePanel.begin { (result) in
//
//      guard result == .OK else {
//        return
//      }
//
//      guard let saveURL = savePanel.url else {
//        return
//      }
//
//      do {
//        //try str.write(to: saveURL, atomically: false, encoding: .utf8)
//
//        let fm = FileManager.default
//        let saved = fm.createFile(atPath: saveURL.absoluteString, contents: data, attributes: [FileAttributeKey.posixPermissions: 0o777])
//
//        os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "saved: \(saved)")
//      } catch {
//        os_log("%{PUBLIC}@", log: OSLog.test, type: .error, "error: \(error)")
//      }
//
//    }
    
    let script = """
    set the logFile to ((path to desktop) as text) & "log.txt"
    set the logText to "This is a text that should be written into the file"

    tell application "Finder"
        if not (exists file logfile) then
            make new file at folder logpath with properties {name:myFile}
        end if
    end tell

    try
        open for access file the logFile with write permission
        write (logText & return) to file the logFile starting at eof
        close access file the logFile
    on error
        try
            close access file the logFile
        end try
    end try
    """
    
    guard let appleScript = NSAppleScript(source: script) else {
      return
    }
    let success = appleScript.compileAndReturnError(nil)
    
  }
  
}

struct ContentView: View {
  
  @EnvironmentObject var appEnvironment: AppEnvironment
  
  var body: some View {
    
    VStack {
      
      ScrollView(.vertical) {
        ForEach(appEnvironment.subSystemURLs, id: \.self) { url in
          SubSystemView(subSystemURL: url)
        }
      }
      
      Button(action: {
        //test.test()
      }, label: {
        Text("Test")
      })
      
      Button(action: {
        os_log("%{PUBLIC}@", log: OSLog.test, type: .debug, "test")
      }, label: {
        Text("Log test")
      })
      
      Button(action: {
        os_log("%{PUBLIC}@", log: OSLog.preview, type: .debug, "preview")
      }, label: {
        Text("Log preview")
      })
      
        Button(action: {
          //test.read()
        }, label: {
          Text("Read")
        })
      
    }
    
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppEnvironment())
  }
}
