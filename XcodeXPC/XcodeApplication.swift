//
//  XcodeXPCProtocol.swift
//  XcodeXPC
//
//  Created by Aleksander Kozin on 20/1/26.
//  Copyright © 2026 El Machine, Alex Kozin. All rights reserved.
//

import AppKit
import Foundation
import ScriptingBridge

//protocol MailApplication {
//    @objc optional var selection: SBElementArray { get }
//    @objc optional func extractNameFrom(_ x: String) -> String
//    @objc optional func extractAddressFrom(_ x: String) -> String
//}

//public protocol SBObjectProtocol: NSObjectProtocol {
//    func get() -> Any!
//}

public protocol SBApplicationProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
    var isRunning: Bool { get }
}


public
protocol XcodeApplication {

//    @objc optional var activeWorkspaceDocument: SBObject { get }
}

//protocol XcodeApplication {

//    var windows: [SBObject] { get }

//}

//@objc
//protocol XcodeGenericMethods {
//
//}
//
//@objc
//protocol XcodeWindow where Self: SBObject {
//
//}
//
