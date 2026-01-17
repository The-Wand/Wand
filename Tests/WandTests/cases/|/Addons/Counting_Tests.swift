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
import XCTest
import Wand

class CountingTests: XCTestCase {

    func test_Every_Counting()
    {
        let bound = ClosedRange.any.any

        let e = expectation()
        e.expectedFulfillmentCount = bound

        var expect = 0

        let wand = |.every { (string: String, count: Int) in

            expect = count
            e.fulfill()
        }

        (0..<bound).forEach { _ in
            wand.add(String.any)
        }

        waitForExpectations()
        XCTAssert(expect == bound - 1)
    }

    func test_While_Counting()
    {
        let bound = ClosedRange.any.any

        let e = expectation()
        e.expectedFulfillmentCount = bound

        var expect = 0

        let wand = |.while { (string: String, count: Int) in

            expect = count
            e.fulfill()

            return count <= bound
        }


        (0..<bound).forEach { _ in
            wand.add(String.any)
        }

        waitForExpectations()
        XCTAssert(expect == bound - 1)
    }

}
