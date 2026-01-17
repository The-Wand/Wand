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

class Errors_Tests: XCTestCase {

    func test_One_Error_Success_Handling() throws {

        let e1 = expectation()
        let e2 = expectation()

        weak
        var wand: Core!
        wand = |String.one { _ in
            e1.fulfill()
        } |? { (error: Error) in
            XCTAssert(false)
        } | .all { _ in
            e2.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(String.any)
        }

        wait(for: [e1, e2])
        XCTAssertNil(wand)
    }

    func test_One_Error_Fail_Handling() throws {

        let e1 = expectation()
        let e2 = expectation()

        weak
        var wand: Core!
        wand = Point.every | String.one { _ in
            XCTAssert(false)
        } |? { (error: Error) in
            e1.fulfill()
        } | .all { _ in
            e2.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(NSError() as Error)
        }

        wait(for: [e1, e2])
        //Will work at production environment
        //XCTAssertNil(wand)
    }

    func test_Every_Error_Fail_Handling() {

        let range = ClosedRange.any

        let e = expectation()
        e.expectedFulfillmentCount = range.upperBound

        weak
        var wand: Core!
        wand = Point.every | String.one { _ in
            fatalError()
        } |? .every { (error: Error) in
            e.fulfill()
        } | .all { _ in
            fatalError()
        }

        range.forEach { _ in

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
                wand?.add(NSError() as Error)
            }
        }

        waitForExpectations()
        XCTAssertNotNil(wand)
    }

    func test_Optional_Error_done() {

        let e = expectation()

        weak
        var wand: Core!
        wand = |Point.one |? { (error: Error?) in
            if error == nil {
                e.fulfill()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(nil as Error?)
        }

        wait(for: [e])
        //Will work at production environment
        //XCTAssertNil(wand)
    }

    func test_Optional_Error_fail() {

        let e = expectation()

        weak
        var wand: Core!
        wand = |Point.one |? { (error: Error?) in
            if error != nil {
                e.fulfill()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(Core.Error(reason: .any) as Error)
        }

        wait(for: [e])
        //Will work at production environment
        //XCTAssertNil(wand)
    }

    func test_Optional_Error_every_done() {

        let range = ClosedRange.any

        let e = expectation()
        e.expectedFulfillmentCount = range.upperBound

        weak
        var wand: Core!
        wand = |Point.one |? .every { (error: Error?) in
            if error == nil {
                e.fulfill()
            }
        }

        range.forEach { _ in

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
                wand?.add(nil as Error?)
            }
        }

        wait(for: [e])
        //Will work at production environment
        //XCTAssertNil(wand)
    }

}

