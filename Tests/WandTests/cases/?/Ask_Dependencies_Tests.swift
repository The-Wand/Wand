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

class Ask_Dependencies_Tests: XCTestCase {

    func test_Dependency_Once() throws {

        let e = expectation()

        let point = Point.any

        weak
        var wand: Core!
        wand = |.one { (point: Point) in
            e.fulfill()
        } |? { (string: String) in //ask3

        }

        wand.add(point)

        waitForExpectations()
        XCTAssertNil(wand)
    }

    func test_Dependency_Every() throws {

        let e = expectation()

        let point = Point.any

        weak
        var wand: Core!
        wand = |.every { (point: Point) in
            e.fulfill()
        } |? .every { (string: String) in

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

    func test_Scope_to_Dependency()
    {
        let e = expectation()

        let point = Point.any

        var wand: Core!
        wand = point |? .every { (string: String) in
            e.fulfill()
        }

        wand.add(String.any)

        waitForExpectations()
        XCTAssertNotNil(wand)

        wand = nil
        XCTAssertNil(wand)
    }

    func test_Scope_to_Ask_Dependency()
    {
        let e = expectation()

        let point = Point.any


        let ask = Ask.every { (string: String) in
            e.fulfill()
        }

        var wand: Core! //ask
        wand = point |? ask

        wand.add(String.any)

        waitForExpectations()
        XCTAssertNotNil(wand)

        wand = nil
        XCTAssertNil(wand)
    }

    func test_Dependency()
    {
        let e = expectation()

        let ask = Ask.every { (string: String) in
            e.fulfill()
        }

        var wand: Core! //ask4
        wand = |?ask | ask.dependency { (point: Point) in
            fatalError()
        }

        wand.add(String.any)

        waitForExpectations()
        XCTAssertNotNil(wand)

        wand = nil
        XCTAssertNil(wand)
    }

//    func test_Ask_Dependency()
//    {
//        let e = expectation()
//
//        let ask = Ask.every { (string: String) in
//            e.fulfill()
//        }
//
//        var wand: Core! //ask4
//        wand = |?ask | ask.dependency { (point: Point) in
//            fatalError()
//        }
//
//        wand.add(String.any)
//
//        waitForExpectations()
//        XCTAssertNotNil(wand)
//
//        wand = nil
//        XCTAssertNil(wand)
//    }

}
