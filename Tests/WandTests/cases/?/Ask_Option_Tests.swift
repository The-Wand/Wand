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

class Ask_Option_Tests: XCTestCase {

    func test_One_Optional_Strong() throws {

        let e = expectation()

        let point = Vector.any

        var wand: Core!
        wand = |?{ (point: Vector) in
            e.fulfill()
        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNotNil(wand)
    }

    func test_One_Optional_Weak() throws {

        weak
        var wand: Core?
        wand = |?{ (point: Vector) in
            fatalError()
        }

        XCTAssertNil(wand)
    }

    func test_Every_Optional_Strong() throws {

        let e = expectation()

        let point = Vector.any

        var wand: Core!
        wand = |?.every { (point: Vector) in
            e.fulfill()
        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNotNil(wand)
    }

    func test_Every_Optional_Weak() throws {

        weak
        var wand: Core?
        wand = |?.every { (point: Vector) in
            fatalError()
        }

        XCTAssertNil(wand)
    }

    func test_While_Optional_Strong() throws {

        let e = expectation()

        let point = Vector.any

        var wand: Core!
        wand = |?.while { (point: Vector) in

            e.fulfill()
            return true
        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNotNil(wand)
    }

    func test_While_Optional_Weak() throws {

        weak
        var wand: Core?
        wand = |?.while { (point: Vector) in
            fatalError()
        }

        XCTAssertNil(wand)
    }

}
