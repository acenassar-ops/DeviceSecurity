//
//  DeviceSecurityTests.swift
//  DeviceSecurity
//
//  Created by Christopher Nassar on 15/07/2025.
//

import XCTest
@testable import DeviceSecurity

final class DeviceSecurityTests: XCTestCase {
    
    func testIsJailBroken() {
        let isJailBroken = RootChecker().isJailbroken()
        XCTAssertTrue(isJailBroken, "Device should be JailBroken in this test environment")
    }
    
    func testIsDebuggerAttached() {
        XCTAssertTrue(isDebuggerAttached, "Device should be debugger attached in this test environment")
    }
    
    func testIsSimulator() {
        XCTAssertFalse(isRunningOnSimulator, "Device should not be on simulator in this test environment")
    }
    
    func testIsSecure() {
        let isSecure = DeviceSecurity.isSecure()
        XCTAssertFalse(isSecure, "Device should not be secure in this test environment")
    }
}
