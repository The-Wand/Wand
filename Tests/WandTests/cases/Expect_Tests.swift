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

class Expect_T_Tests: XCTestCase {

    func test_Every() throws {
        //Insert 'count' times
        let count: Int = .any(in: 1...22)

        let e = expectation()
        e.expectedFulfillmentCount = count

        var last: Vector?

        //Wait for 'count' Points
        weak
        var wand: Core!
        wand = |.every { (point: Vector) in
            //Is equal?
            if point == last {
                e.fulfill()
            }
        }

        //Put for 'count' Vector
        var i = 0
        (0..<count).forEach { [weak wand] _ in
            let point = Vector.any
            last = point

            wand?.add(point)

            i = i+1
        }

        waitForExpectations(timeout: .default)

        //TODO: add is closed test
        wand.close()
    }
 
    func test_One() throws {
        let e = expectation()

        let point = Vector.any

        weak
        var wand: Core!

        var handlePerformance: Performance!

        wand = |.one { (point: Vector) in

            handlePerformance.measure()
            e.fulfill()
        }

        handlePerformance = Performance(of: "AskingNil answer")
        wand.add(point)

        waitForExpectations()
        XCTAssertNil(wand)
    }

    func test_While() throws {

        func put() {
            DispatchQueue.main.async {
                wand.add(Vector.any)
            }
        }

        let e = expectation()

        weak
        var wand: Core!
        wand = |.while { (point: Vector) in

            if point.t > 2 {
                e.fulfill()
                return false
            } else {
                put()
                return true
            }

        }

        put()

        waitForExpectations()
        XCTAssertNil(wand)
    }

}
