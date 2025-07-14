//
//  DeviceSecurity.swift
//  DeviceSecurity
//
//  Created by Christopher Nassar on 14/07/2025.
//

public struct DeviceSecurity {
    /// Public general API to check for any secruity breach
    static public func isSecure() -> Bool {
        return !RootChecker().isJailbroken() && !isRunningOnSimulator && !isDebuggerAttached
    }
}

