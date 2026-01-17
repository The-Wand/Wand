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

import Wand
import XCTest

class Expect_Any_Tests: XCTestCase {

    func test_Any() throws {

        //Insert 'count' times
        let count: Int = .any(in: 1...42)

        let e = expectation()
        e.expectedFulfillmentCount = count

        var wand: Wand.Core!
        
        wand = Point.every | String.every | .any { _ in
            e.fulfill()
        }

        (0..<count).forEach { _ in

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
                if .random() {
                    wand?.add(Point.any)
                } else {
                    wand?.add(String.any)
                }
            }

        }

        waitForExpectations()
    }

    func test_Any_Performance() throws {

        let e = expectation()

        let wand = Point.every | String.every

        var handlePerformance: Performance!
        Performance(of: "Ask<Any> add") {

            wand | .any { _ in

                handlePerformance.measure()
                e.fulfill()
            }

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in

            handlePerformance = Performance(of: "Ask<Any> handle")

            if .random() {
                wand?.add(Point.any)
            } else {
                wand?.add(String.any)
            }
        }

        waitForExpectations()
    }

}
