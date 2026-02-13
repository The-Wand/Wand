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

//import Network

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

    let pickAxe = "https://deeprockgalactic.wiki.gg/images/thumb/GearGraphic_PickAxe.png/600px-GearGraphic_PickAxe.png?8d8b42"

    var body: some View {
        HStack {
            if #available(iOS 15.0, watchOS 8.0, *) {
                AsyncImage(
                    url: URL(string: pickAxe),
                    scale: 2
                )
                .ignoresSafeArea()
//                .blur(radius: 2.0)
            } else {
                Text("Hello, Wand|")
            }


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
        }
//        .onAppear() {
//            Wand.Log.level = .verbose
//            Highload.highload_prod(of: 111_111_111)
//        }
    }
    
}

@available(iOS 14, macOS 12, tvOS 14, watchOS 7, *)
#Preview {
    ContentView()
}
