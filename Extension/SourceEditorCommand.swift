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
import Wand
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

        let handler = { (message: String) in
            completionHandler(NSError(message))
        }

        let buffer = invocation.buffer
//
////        buffer.selections.forEach(\.isSelected) {
////            $0 = false
////        }
//
        let lines = buffer.lines

//        // Reverse the order of the lines in a copy.
//        let updatedText = Array(lines.reversed())
//        lines.removeAllObjects()
//        lines.addObjects(from: updatedText)

        var error: Error? = nil

        let selection = buffer.selections.firstObject as! XCSourceTextRange

        let start = selection.start
        let end = selection.end

        guard start.line == end.line else {
            handler("Select one row")
            return
        }


        let line = lines[start.line] as! String

//        let symbols = String(line.unicodeScalars.filter(CharacterSet.whitespacesAndNewlines.contains))
//
//        let selected = line.substring(from: start.column, to: end.column)

        guard let wand = line.firstIndex(of: "|") else {
            handler("No operator")
            return
        }

        let asyncDeclaration = String(line.suffix(from: wand))

        guard let match: NSTextCheckingResult = asyncDeclaration | "([A-Z])\\w+" else {
            handler("No type")
            return
        }

        let range = match.range

        let type = asyncDeclaration.substring(from: range.location, length: range.length)



//        |.one { (point: Point) in
//        |.every { (point: Point) in
//        |.while { (point: Point) in
//        |{ (point: Point) in
//
//        aaa | .one { (point: Point) in
//
//        |Point.one
//        |Point.every
//
//        let string: String = date|



        let connection = NSXPCConnection(serviceName: "com.el-machine.XcodeXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeXPCProtocol.self)
        connection.resume()
        defer {
            connection.invalidate()
        }

        let xcode = connection.remoteObjectProxy as! XcodeXPCProtocol

        let semaphore = DispatchSemaphore(value: 0)

        xcode.jump(to: type) { (errorMessage) in
            if let errorMessage {
                handler(errorMessage)
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)

        completionHandler(error)
    }
    
}

extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }

        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }

        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return String(self[startIndex ..< endIndex])
    }

    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }

    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
}


@inline(__always)
fileprivate
func |(string: String, pattern: String) -> [NSTextCheckingResult]? {
    try? NSRegularExpression(pattern: pattern, options: [])
        .matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
}

@inline(__always)
fileprivate
func |(string: String, pattern: String) -> NSTextCheckingResult? {
    (string | pattern)?.first
}

struct XPCError: Error {
    let message: String

    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: message]
    }
}

extension NSError {

    convenience
    init(_ message: String) {
        self.init(domain: message, code: 0)
    }

}
