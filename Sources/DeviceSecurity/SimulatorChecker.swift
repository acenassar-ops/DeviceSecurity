//
//  EmulatorChecker.swift
//  DeviceSecurity
//
//  Created by Christopher Nassar on 14/07/2025.
//

import Foundation

// MARK: - Implementation
/// A Boolean value indicating whether the app is running on a simulator.
///
/// This property checks for the presence of the `SIMULATOR_DEVICE_NAME` environment variable,
/// which is automatically set by Xcode when running in a simulator environment.
///
/// - Returns: `true` if the app is running on a simulator; otherwise, `false`.
public var isRunningOnSimulator: Bool {
    return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
}

// MARK: - Usage
/// if isRunningOnSimulator {
///    #warning("Running on a simulator.")
///}
