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

import CoreLocation.CLLocation

import Wand
import XCTest

class Core_Init_Dictionary_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_init_Dictionary() throws {

        let prefix = String(String.any.split(separator: " ").randomElement()!)

        let bool = true
        let int = 4
        let location = CLLocation.any
        let date = Date.any

        let boolKey = prefix + type(of: bool)|
        let intKey = prefix + type(of: int)|
        let locationKey = prefix + type(of: location)|
        let dateKey = prefix + type(of: date)|

        let dictionary: [String: Any] = [boolKey: bool,
                                          intKey: int,
                                     locationKey: location,
                                         dateKey: date]

        var wand: Core! = Core(dictionary: dictionary)
        self.wand = wand

        XCTAssertEqual(wand.get(for: boolKey), bool)
        XCTAssertEqual(wand.get(for: intKey), int)
        XCTAssertEqual(wand.get(for: locationKey), location)
        XCTAssertEqual(wand.get(for: dateKey), date)

        // wand is the same
        XCTAssertTrue(wand === (location as Optional).wand)
        XCTAssertTrue(wand === (date as Optional).wand)

        //Close wand
        weak
        var closed = wand|
        wand = nil

        XCTAssertNil(closed)
        XCTAssertNil(self.wand)

    }

    func test_init_DictionaryLiteral() throws {

        let prefix = String(String.any.split(separator: " ").randomElement()!)

        let bool = true
        let int = 4
        let location = CLLocation.any
        let date = Date.any

        let boolKey = prefix + type(of: bool)|
        let intKey = prefix + type(of: int)|
        let locationKey = prefix + type(of: location)|
        let dateKey = prefix + type(of: date)|

        var wand: Core! = [boolKey: bool,
                            intKey: int,
                       locationKey: location,
                           dateKey: date]
        self.wand = wand

        XCTAssertEqual(wand.get(for: boolKey), bool)
        XCTAssertEqual(wand.get(for: intKey), int)
        XCTAssertEqual(wand.get(for: locationKey), location)
        XCTAssertEqual(wand.get(for: dateKey), date)

        // wand is the same
        XCTAssertTrue(wand === (location as Optional).wand)
        XCTAssertTrue(wand === (date as Optional).wand)

        //Close wand
        weak
        var closed = wand|
        wand = nil

        XCTAssertNil(closed)
        XCTAssertNil(self.wand)

    }



}
