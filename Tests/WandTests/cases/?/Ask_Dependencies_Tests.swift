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

import Wand
import XCTest

class Ask_Dependencies_Tests: XCTestCase {

    func test_Dependency_Once() throws {

        let e = expectation()

        let point = Vector.any

        weak
        var wand: Core!
        wand = |.one { (point: Vector) in
            e.fulfill()
        } |? { (string: String) in

        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNil(wand)
    }

    func test_Dependency_Every() throws {

        let e = expectation()

        let point = Vector.any

        weak
        var wand: Core!
        wand = |.every { (point: Vector) in
            e.fulfill()
        } |? { (string: String) in

        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNotNil(wand)
    }

    //TODO: Fix and enable
    //    func test_Dependency_While() throws {
    //
    //        let limit = (1...4).any
    //
    //        let e = expectation()
    //        e.expectedFulfillmentCount = limit
    //
    //        let point = Vector.any
    //
    //        weak
    //        var wand: Core!
    //        wand = |.while { (point: Vector, count: Int) in
    //            e.fulfill()
    //            print(point)
    //
    //            return count < limit
    //        } |/ { (string: String) in
    //
    //        }
    //
    //        (0..<limit).forEach { _ in
    //            wand.add(point)
    //        }
    //
    //        waitForExpectations()
    //        XCTAssertNil(wand)
    //    }

}
