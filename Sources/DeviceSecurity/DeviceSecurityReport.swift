//
//  DeviceSecurityReport 2.swift
//  DeviceSecurity
//
//  Created by Christopher Nassar on 15/07/2025.
//


public struct DeviceSecurityReport: Codable {
    public let isSecure: Bool
    public let isJailbroken: Bool
    public let isSimulator: Bool
    public let isDebuggerAttached: Bool
}

extension DeviceSecurityReport: CustomStringConvertible {
    public var description: String {
        """
        🔐 Device Security Report
        -------------------------
        ✅ isSecure:             \(isSecure)
        🧨 Jailbroken:           \(isJailbroken)
        🖥️ Simulator:            \(isSimulator)
        🐞 Debugger Attached:    \(isDebuggerAttached)
        """
    }
}
