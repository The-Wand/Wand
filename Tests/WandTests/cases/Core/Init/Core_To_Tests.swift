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

import CoreLocation.CLLocation

import Wand
import XCTest

class Core_To_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_to_Nil() throws {

        let wand = Core.to(nil as Int?)

        XCTAssertNotNil(wand)
    }

    func test_to_Scope()
    {
        let scope = "🫵"

        let wand = Core.to(scope)

        XCTAssertEqual(wand.get(), scope as String)
        XCTAssertNotNil(wand)
    }

    func test_to_Dictionary() throws {

        let request = URLRequest(url: .any)
        let key = "Request"

        let scope = [key: request]

        let wand = Core.to(scope)

        XCTAssertEqual(wand.get(for: key), request)
        XCTAssertNotNil(wand)
    }

    func test_to_Object()
    {
        let location = CLLocation.any

        let wand = (location as Optional).wand
        let isWanded = (location as Optional).isWanded

        XCTAssertNotNil(isWanded)
        XCTAssertTrue(wand === isWanded)
    }

}
