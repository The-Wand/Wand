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

import Wand

class Data_Tests: XCTestCase {

    func test_Path_Data() {
        let e = expectation()

        "https://api.github.com/gists" | .one { (data: Data) in

            if !data.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_URL_Data() {
        let e = expectation()

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        url | .one { (data: Data) in

            if !data.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

}

#endif
