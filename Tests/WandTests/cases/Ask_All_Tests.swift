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

import Wand
import XCTest

class Expect_All_Tests: XCTestCase {

    func test_All() throws {

        let e = expectation(description: "event.all")
        e.assertForOverFulfill = false

        weak
        var wand: Core!
        wand = Vector.one | String.one | .all { _ in
            e.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(Vector.any)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(String.any)
        }

        waitForExpectations()
        
    }

}
