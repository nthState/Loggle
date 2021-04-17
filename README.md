# Loggle

## _A Tool to Easily Show/Hide OSLogs_

Are you fed up with manually toggling OS Log?  
Are you fed up with writing a script to configure your OS Logs?  

Are you looking for an easy, quick way to toggle OSLog?


![Screenshot 1l](https://github.com/nthState/Loggle/blob/main/Assets/Screenshots/screen1.png?raw=true)


### Why is this not in the AppStore?

Sandboxing - We need to be able to write to `/Library/Preferences/Logging/Subsystems` - which is outside of the App's Sandbox

### Why is this an App and not just a button in Xcode?

I'd love to add this as a button to Xcode, it would fit just here:

![Screenshot 1l](https://github.com/nthState/Loggle/blob/main/Assets/Screenshots/XcodeDebugBar.png?raw=true)


### Code

You may have a OSLog set up like:

```swift
import os.log

extension OSLog {
    
    // MARK: - Subsystem
    
    /// The subsystem for the app
    public static var appSubsystem = "com.nthstate.Loggle"
    
    // MARK: - Categories
    
    /// GPU Effects
    static let gpuEffects = OSLog(subsystem: OSLog.appSubsystem, category: "GPU Effects")
    
    /// StoreKit
    static let storeKit = OSLog(subsystem: OSLog.appSubsystem, category: "StoreKit")
}
```

and you may be logging like:

```swift
os_log("%{PUBLIC}@", log: OSLog.gpuEffects, type: .debug, "GPU Time Stamp")
```

How do you toggle this via the command line?

```bash
# Pick the correct level: off/debug/info/default
sudo log config --mode "level:debug" --subsystem com.mybundle --category "GPU Effects"
```

## How does this App work? 

This App supports two ways of controling OSLog output:

1. Issuing direct commands to `log`
or
2. Editing bundle.plist files at `/Library/Preferences/Logging/Subsystems`

The bundle.plist files look similar to:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>StoreKit</key>
  <dict>
    <key>Level</key>
    <dict>
      <key>Enable</key>
      <string>default</string>
      <key>Persist</key>
      <string>Inherit</string>
    </dict>
  </dict>
  <key>GPU Effects</key>
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
```
