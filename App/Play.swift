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

import SwiftUI
import Wand

import Network

extension String: @retroactive AskNil {}
extension String: @retroactive AskT {}
extension String: @retroactive Expecting {

}

@available(iOS 14, macOS 12, tvOS 14, watchOS 7, *)
@main
struct PlayApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}

@available(iOS 14, macOS 12, tvOS 14, watchOS 7, *)
struct ContentView: View {

    var body: some View {
        VStack {
            Image(systemName: "wand.and.stars")
            Text("Hello, Wand|")
//            Button("Receive") {
//                |.while { (connection: NWConnection) in
//                    print("✅ \(connection)")
//                    return true
//                }
//            }
//            Button("Transfer") {
//                |.while { (result: NWBrowser.Result) in
//                    print("✅ \(result)")
//                    return true
//                }
//
//            }
        }.onAppear() {

            let a = "\u{0358}"
            print(a)
//            Wand.Log.level = .verbose
//            Highload.highload_prod(of: 111_111_111)
        }
    }
    
}

@available(iOS 14, macOS 12, tvOS 14, watchOS 7, *)
#Preview {
    ContentView()
}
