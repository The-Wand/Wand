///
/// Copyright 2020 Aleksander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Aleksander Kozin
/// The Wand

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {


//        let buffer = invocation.buffer
//
////        buffer.selections.forEach(\.isSelected) {
////            $0 = false
////        }
//
//        let lines = invocation.buffer.lines
//        // Reverse the order of the lines in a copy.
//        let updatedText = Array(lines.reversed())
//        lines.removeAllObjects()
//        lines.addObjects(from: updatedText)

        let connection = NSXPCConnection(serviceName: "com.el-machine.XcodeXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeXPCProtocol.self)
        connection.resume()
        defer {
            connection.invalidate()
        }

        let xcode = connection.remoteObjectProxy as! XcodeXPCProtocol

        let semaphore = DispatchSemaphore(value: 0)

        var error: NSError? = nil
        xcode.jumpToDefinition { (errorMessage) in
            error = NSError(domain: errorMessage, code: 0)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)

        completionHandler(error)
    }
    
}
