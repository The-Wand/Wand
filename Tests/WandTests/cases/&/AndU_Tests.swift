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

import Testing
import XCTest
import Wand

class And_Tests: XCTestCase {

    func test_Handler_And_Handler()
    throws
    {
        let e = expectation()
        e.expectedFulfillmentCount = 2

        let wand =
        |({ (point: Point) in
            e.fulfill()
        } & { (string: String) in
            e.fulfill()
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            wand.add(Point.any)
            wand.add(String.any)
        }

        waitForExpectations()
    }

    func test_Ask_And_Handler()
    {
        let e = expectation()
        e.expectedFulfillmentCount = 2

        let ask = Ask.one { (point: Point) in
            e.fulfill()
        }

        let wand: Core = nil
        wand | ask & { (string: String) in
            e.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            wand.add(Point.any)
            wand.add(String.any)
        }

        waitForExpectations()
    }

    func test_Ask_And_Handler_While()
    {
        let count: Int = .any(in: 1...42)

        let e = expectation()
        e.expectedFulfillmentCount = 1 + count

        let ask = Ask.one { (point: Point) in
            e.fulfill()
        }

        var i = 0

        let wand = Core()
        wand | ask & { (string: String) in
            e.fulfill()

            i += 1
            print(i)
            return i < count
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            wand.add(Point.any)

            (0..<count).forEach { _ in
                wand.add(String.any)
            }
        }

        waitForExpectations()
    }

}
