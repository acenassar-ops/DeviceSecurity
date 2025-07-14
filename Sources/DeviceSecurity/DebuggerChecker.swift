//
//  DebuggerChecker
//  DeviceSecurity
//
//  Created by Christopher Nassar on 14/07/2025.
//

import Foundation
import Darwin

// MARK: - Implementation
/// A Boolean value indicating whether a debugger is currently attached to the process.
///
/// This check uses the `sysctl` system call to query the process info
/// and determine if it is being traced (e.g., by Xcode's debugger).
///
/// - Returns: `true` if a debugger is attached; otherwise, `false`.
public var isDebuggerAttached: Bool {
    let name = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var info = kinfo_proc()
    var infoSize = MemoryLayout<kinfo_proc>.stride

    // Copy to local variable to avoid overlapping access
    var nameCopy = name
    
    let result = nameCopy.withUnsafeMutableBufferPointer { namePtr -> Int32 in
        return sysctl(namePtr.baseAddress, u_int(name.count), &info, &infoSize, nil, 0)
    }

    guard result == 0 else {
        return false
    }

    return (info.kp_proc.p_flag & P_TRACED) != 0
}

// MARK: - Usage

///if isDebuggerAttached {
///    #if os(iOS) || os(tvOS) || os(watchOS)
///    fatalError("Debugger attached while running on a simulator. Please disconnect the debugger and try again.")
///#else
///    fatalError("Debugger attached. Please disconnect the debugger and try again.")
///#endif
///}
