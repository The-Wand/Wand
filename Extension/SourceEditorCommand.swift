//
//  SourceEditorCommand.swift
//  Selector
//
//  Created by Aleksander Kozin on 20/1/26.
//  Copyright © 2026 El Machine, Alex Kozin. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {


        let buffer = invocation.buffer

//        buffer.selections.forEach(\.isSelected) {
//            $0 = false
//        }

        let lines = invocation.buffer.lines
        // Reverse the order of the lines in a copy.
        let updatedText = Array(lines.reversed())
        lines.removeAllObjects()
        lines.addObjects(from: updatedText)

        completionHandler(nil)
    }
    
}
