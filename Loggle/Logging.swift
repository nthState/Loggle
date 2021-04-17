//
//  Logging.swift
//  Loggle
//
//  Created by Chris Davis on 16/04/2021.
//

import os.log

extension OSLog {
    
    // MARK: - Subsystem
    
    /// The subsystem for the app
    public static var appSubsystem = "com.nthstate.Loggle"
    
    // MARK: - Categories
    
    /// Test
    static let test = OSLog(subsystem: OSLog.appSubsystem, category: "Test")
    
    /// Preview
    static let preview = OSLog(subsystem: OSLog.appSubsystem, category: "Preview")
  
}
