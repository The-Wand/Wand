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
import ScriptingBridge

class XcodeXPC: NSObject, XcodeXPCProtocol {

    @objc
    func jump(to type: String, reply: @escaping (String?)->()) {


//        let app2 = SBApplication(bundleIdentifier: "com.apple.dt.Xcode") as! XcodeApplication

        guard let app = SBApplication(bundleIdentifier: "com.apple.dt.Xcode") else {
            reply("Where is Xcode?")
            return
        }

        let workspaceDocument = app.activeWorkspaceDocument
        let root = workspaceDocument.file.deletingLastPathComponent()


        let manager = FileManager.default
        let keys: [URLResourceKey] = [.isDirectoryKey]

        guard let files = manager.enumerator(at: root, includingPropertiesForKeys: keys) else {
            reply("No files")
            return
        }

        var destination: URL? = nil
        for case let url as URL in files {
            let values = try? url.resourceValues(forKeys: Set(keys))
            guard let values, values.isDirectory == false else {
                continue
            }

            let path = url.path

            if (path.firstRange(of: type) != nil) {
                destination = url
                print(destination as Any)
//                break
            }

        }

        if let destination {
            DispatchQueue.main.async {
                app.open(destination)
            }

            reply(nil)
        } else {
            reply("Destination not found")
        }

//        reply(type)
    }
    
}

extension SBApplication {

    var windows: [SBObject] {
        value(forKey: "windows") as! [SBObject]
    }

    var activeWorkspaceDocument: SBObject {
        value(forKey: "activeWorkspaceDocument") as! SBObject
    }

    func open(_ url: URL) {
        let sel = NSSelectorFromString("open:")
        perform(sel, with: url.standardizedFileURL)
    }

}

extension SBObject {

    var name: String {
        value(forKey: "name") as! String
    }

    var file: URL {
        value(forKey: "file") as! URL
    }

}
