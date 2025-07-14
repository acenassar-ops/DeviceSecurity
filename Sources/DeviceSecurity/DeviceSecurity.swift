//
//  DeviceSecurity.swift
//  DeviceSecurity
//
//  Created by Christopher Nassar on 14/07/2025.
//

import Foundation

public struct DeviceSecurity {
    /// Entry point for checking device security.
    ///
    /// - Parameter canOpenUrlChecker: Optional closure to determine whether specific URL schemes (like `cydia://`) are available.
    ///   You should pass `UIApplication.shared.canOpenURL(_)` from the main app context.
    ///
    /// - Returns: `true` if the device appears secure; otherwise, `false`.
    public static func isSecure(canOpenUrlChecker: ((URL) -> Bool)? = nil) -> Bool {
        let rootChecker = RootChecker(canOpenUrlChecker: canOpenUrlChecker)
        return !rootChecker.isJailbroken()
            && !isRunningOnSimulator
            && !isDebuggerAttached
    }
}

