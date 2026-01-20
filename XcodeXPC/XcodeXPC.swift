//
//  XcodeXPC.swift
//  XcodeXPC
//
//  Created by Aleksander Kozin on 20/1/26.
//  Copyright © 2026 El Machine, Alex Kozin. All rights reserved.
//

import Foundation
import ScriptingBridge
import OSLog

/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
class XcodeXPC: NSObject, XcodeXPCProtocol {
    
    /// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
    @objc func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (Int) -> Void) {
        let response = firstNumber + secondNumber
        reply(response)
    }

    @objc
    func jumpToDefinition(reply: @escaping (String)->() ) {
        guard let app = SBApplication(bundleIdentifier: "com.apple.dt.Xcode") else {

            reply("")
            return
        }


        let windows = app.value(forKey: "windows")


        let xcode = app as? XcodeApplication

//        let windows = app.windows
//        let window = windows.firstObject


        reply("aaa")
    }
    
}
