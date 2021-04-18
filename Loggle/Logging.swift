//
//  Logging.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
//

import os.log

extension OSLog {
    
    // MARK: - Subsystem
    
    /// The subsystem for the app
    public static var appSubsystem = "com.nthstate.Loggle"
    
    // MARK: - Categories
    
    /// Read/Write files
    static let fileIO = OSLog(subsystem: OSLog.appSubsystem, category: "File IO")
    
    /// Running AppleScripts
    static let applescript = OSLog(subsystem: OSLog.appSubsystem, category: "AppleScript")
  
  /// Serialization of data / Codable
  static let serialization = OSLog(subsystem: OSLog.appSubsystem, category: "Serialization")
  
}
