// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// MARK: - Implementation
/// A utility for detecting whether the current iOS device is jailbroken.
///
/// This detector provides multiple heuristics such as file existence, sandbox violations,
/// symbolic link presence, and the ability to open known jailbreak-related URL schemes.
///
/// Usage:
/// ```swift
/// let detector = JailbreakDetector(canOpenUrlChecker: { UIApplication.shared.canOpenURL($0) })
/// if detector.isJailbroken() {
///     // Device appears to be jailbroken
/// }
/// ```
///
internal struct RootChecker {

    /// Creates a new `JailbreakDetector` instance.

    public var canOpenUrlChecker: ((URL) -> Bool)?
    
    init(canOpenUrlChecker: ((URL) -> Bool)? = nil) {
        self.canOpenUrlChecker = canOpenUrlChecker
    }
    
    /// Indicates whether the current device is likely jailbroken.
    ///
    /// This performs a series of heuristic checks for common jailbreak indicators,
    /// such as known file paths, sandbox violations, symbolic links, and URL schemes.
    ///
    /// - Returns: `true` if the device appears to be jailbroken; otherwise, `false`.
    public func isJailbroken() -> Bool {
        return hasJailbreakFiles() ||
               canWriteOutsideSandbox() ||
               canOpenCydia() ||
               hasSymbolicLinks()
    }

    // Checks for existence of known jailbreak-related files.
    private func hasJailbreakFiles() -> Bool {
        let jailbreakPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        for path in jailbreakPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    // Attempts to write a file outside the app sandbox.
    // This should fail on a non-jailbroken device.
    private func canWriteOutsideSandbox() -> Bool {
        let testString = "Jailbreak Test"
        do {
            try testString.write(toFile: "/private/jailbreak.txt", atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: "/private/jailbreak.txt")
            return true
        } catch {
            return false
        }
    }
    
    // Check if Cydia URL scheme can be opened.
    private func canOpenCydia() -> Bool {
        guard let checker = canOpenUrlChecker,
              let cydiaUrl = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return checker(cydiaUrl)
    }
    
    // Checks for symbolic links at common jailbreak file paths.
    private func hasSymbolicLinks() -> Bool {
        let fileManager = FileManager.default
        let paths = [
            "/Applications",
            "/Library/Ringtones",
            "/usr/libexec",
            "/var/mobile/Library/SBSettings"
        ]
        
        for path in paths {
            do {
                let attributes = try fileManager.attributesOfItem(atPath: path)
                if let fileType = attributes[.type] as? FileAttributeType,
                   fileType == .typeSymbolicLink {
                    return true
                }
            } catch {
                continue
            }
        }
        return false
    }
}

// MARK: - Note
/// Make sure to add this to the target plist
///
///<key>LSApplicationQueriesSchemes</key>
///<array>
///    <string>cydia</string>
///</array>

// MARK: - Usage
/// let checker = DeviceSecurity(canOpenUrlChecker: { url in
/// UIApplication.shared.canOpenURL(url)
/// })
