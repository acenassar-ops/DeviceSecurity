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
    
    /// Generates a runtime security report containing device integrity flags.
    ///
    /// This method evaluates whether the device is jailbroken, running on a simulator,
    /// or currently being debugged, and returns a structured report summarizing the results.
    ///
    /// - Parameter canOpenUrlChecker: An optional closure used to check whether a URL scheme (such as `cydia://`)
    ///   can be opened. This is used to support jailbreak detection. You may pass
    ///   `UIApplication.shared.canOpenURL` from the main app layer when available.
    ///
    /// - Returns: A `DeviceSecurityReport` containing flags for each individual check and an overall `isSecure` status.
    public static func generateReport(
        canOpenUrlChecker: ((URL) -> Bool)? = nil
    ) -> DeviceSecurityReport {
        let isSimulator = isRunningOnSimulator
        let isDebugger = isDebuggerAttached
        let isJailbroken = RootChecker(canOpenUrlChecker: canOpenUrlChecker).isJailbroken()

        return DeviceSecurityReport(
            isSecure: !(isSimulator || isDebugger || isJailbroken),
            isJailbroken: isJailbroken,
            isSimulator: isSimulator,
            isDebuggerAttached: isDebugger
        )
    }
}

