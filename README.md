# Loggle

https://stackoverflow.com/questions/34717355/getting-privilege-to-write-a-file-to-library-colorsync-profiles-in-a-mac-appli
https://developer.apple.com/documentation/os/logging/customizing_logging_behavior_while_debugging
https://medium.com/@acwrightdesign/creating-a-macos-menu-bar-application-using-swiftui-54572a5d5f87


sudo log config --mode "level:default" --subsystem "com.nthstate.Loggle"


#do shell script "/usr/bin/log config --status" with administrator privileges
set myvar to "sdfsf"
do shell script "echo \" & myvar & \" > /Library/Preferences/Logging/Subsystems/a.txt" with administrator privileges




```
AuthorizationExecuteWithPrivileges
osascript -e
osascript -e `do shell script "/usr/bin/log config --status" with administrator privileges`


osascript -e 'tell application "Terminal" to do script "/usr/bin/log config --status"'

osascript -e 'tell application "Terminal" to activate'
osascript -e 'tell application "Terminal" to do script "echo HELLO"'

osascript -e 'tell application "Terminal" to do script "echo HELLO" with administrator privileges'


osascript -e 'do shell script "/usr/bin/log config --status" with administrator privileges'



Enable:
sudo log config --mode "level:debug" --subsystem com.your_company.your_subsystem_name

Read:
sudo log config --status --subsystem com.your_company.your_subsystem_name



```

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Preview</key>
  <dict>
    <key>Level</key>
    <dict>
      <key>Enable</key>
      <string>default</string>
      <key>Persist</key>
      <string>Inherit</string>
    </dict>
  </dict>
  <key>Test</key>
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



try
  open for access file the logFile with write permission
  write (logText & return) to file the logFile starting at eof
  close access file the logFile
on error
  try
    close access file the logFile
  end try
end try


set myFile to "TestReport.txt"
set p to POSIX file "/Library/Preferences/Logging/Subsystems"
set rr to ((path to desktop) as text)
set the logFile to ((path to) as text) & "log.txt"
set the logText to "This is a text that should be written into the file"

tell application "Finder" 
  if not (exists file logFile) then
    make new file at folder p with properties {name:myFile}
  end if
end tell
