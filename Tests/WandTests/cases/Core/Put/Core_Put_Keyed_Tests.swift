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

class Core_Put_Keyed_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_put_keyed() throws {

        var wand: Core! = Core()
        self.wand = wand

        let bool = true
        let int = 4

        let location = CLLocation.any
        let date = Date.any

        wand(b: bool, i: int, l: location, d: date)

        XCTAssertEqual(wand.get(for: "b"), bool)
        XCTAssertEqual(wand.get(for: "i"), int)
        XCTAssertEqual(wand.get(for: "l"), location)
        XCTAssertEqual(wand.get(for: "d"), date)

        //TODO: Fix and reenable
        // wand is the same
        //        XCTAssertTrue(wand === (location as Optional).wand)
        //        XCTAssertTrue(wand === (date as Optional).wand)

        //Close wand
        weak
        var closed = wand|
        wand = nil

        XCTAssertNil(closed)
        XCTAssertNil(self.wand)
    }


}
