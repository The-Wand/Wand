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

import Any_

import Wand
import XCTest

class Core_Init_Array_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_init_Array() throws {
 
        let bool = Bool.any
        let int = Int.any
        let location = CLLocation.any
        let date = Date.any

        let array: [Any] = [bool, int, location, date]

        let wand = Core(array: array)

        XCTAssertEqual(bool, wand.get())
        XCTAssertEqual(int, wand.get())
        XCTAssertEqual(location, wand.get())
        XCTAssertEqual(date, wand.get())
    }
    

    func test_init_ArrayLiteral() throws {

        let bool =  Bool.any
        let int = Int.any
        let location = CLLocation.any
        let date = Date.any

        let wand: Core = [bool, int, location, date]

        XCTAssertEqual(bool, wand.get())
        XCTAssertEqual(int, wand.get())
        XCTAssertEqual(location, wand.get())
        XCTAssertEqual(date, wand.get())
    }

    func test_to_Array() throws {

        let bool = Bool.any
        let int = Int.any
        let location = CLLocation.any
        let date = Date.any

        let array: [Any] = [bool, int, location, date]

        let wand = Core.to(array)

        XCTAssertEqual(bool, wand.get())
        XCTAssertEqual(int, wand.get())
        XCTAssertEqual(location, wand.get())
        XCTAssertEqual(date, wand.get())
        XCTAssertNotNil(wand)
    }
    
}
