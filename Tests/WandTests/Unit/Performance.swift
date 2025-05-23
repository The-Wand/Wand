///
/// Copyright 2020 Alexander Kozin
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
/// Created by Alex Kozin
/// El Machine 🤖

import Foundation

/// Use it when Xcode lost your status diamonds
public
struct Performance {

    private
    let label: String

    private
    let start = Date().timeIntervalSince1970

    public
    init(of label: String = #function) {
        self.label = label
    }

    public
    static
    func measure(of label: String = #function, block: ()->() ) {

        #if DEBUG
            let start = Date().timeIntervalSince1970

            block()

            let delta = Date().timeIntervalSince1970 - start
            print("🏎️ \(label) : " + String(format: "%.7f", delta))
        #endif

    }

    public
    func measure() {

        #if DEBUG
            let delta = Date().timeIntervalSince1970 - start
            print("🏎️ \(label) : " + String(format: "%.7f", delta))
        #endif

    }

}
