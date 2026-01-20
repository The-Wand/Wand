//
//  XcodeXPCProtocol.swift
//  XcodeXPC
//
//  Created by Aleksander Kozin on 20/1/26.
//  Copyright © 2026 El Machine, Alex Kozin. All rights reserved.
//

import Foundation
import ScriptingBridge

@objc protocol MailApplication {
    @objc optional var selection: SBElementArray { get }
    @objc optional func extractNameFrom(_ x: String) -> String
    @objc optional func extractAddressFrom(_ x: String) -> String
}

protocol XcodeApplication {

//    var windows: [SBObject] { get }

}

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
