///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

#if canImport(Foundation)
import Foundation
import XCTest

import Wand_URL
import Wand

@available(visionOS, unavailable)
class JSON_Dictionary_Tests: XCTestCase {

    func test_Path_to_Dictionary() {
        let e = expectation()

        let path = "https://api.github.com/repositories/804244016"
        path | { (dictionary: [String: Any]) in

            if !dictionary.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    @available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
    func test_URL_Dictionary() {
        let e = expectation()

        let q = URLQueryItem(name: "q", value: "swift")

        var url = URL(string: "https://api.github.com/repositories/804244016")!
        url.append(queryItems: [q])

        url | { (dictionary: [String: Any]) in

            if !dictionary.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

}

#endif
