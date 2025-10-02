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

class Core_Init_Tests: XCTestCase {

    weak
    var wand: Core?
    
    func test_init_BooleanLiteral() throws {

        let wand: Wand.Core = true

        XCTAssertEqual(wand.get(), true)
        XCTAssertNotNil(wand)

    }

    func test_init_ExtendedGraphemeClusterLiteral() throws {

        let wand: Wand.Core = "🫱🏿‍🫲🏻"

        XCTAssertEqual(wand.get(), "🫱🏿‍🫲🏻")
        XCTAssertNotNil(wand)

    }

    func test_init_FloatLiteral() throws {

        let wand: Wand.Core = 2.0

        XCTAssertEqual(wand.get(), 2.0 as Float)
        XCTAssertNotNil(wand)

    }

    func test_init_IntegerLiteral() throws {

        let wand: Wand.Core = 4

        XCTAssertEqual(wand.get(), 4)
        XCTAssertNotNil(wand)

    }


    func test_init_Nil() throws {

        let wand = Core.to(nil as Int?)

        XCTAssertNotNil(wand)

    }

    func test_init_NilLiteral() throws {

        let wand: Wand.Core = nil

        XCTAssertNotNil(wand)

    }

    func test_init_StringLiteral() throws {

        let wand: Wand.Core = "one"

        XCTAssertEqual(wand.get(), "one")
        XCTAssertNotNil(wand)

    }

    func test_init_StringInterpolation() throws {
    }

    //TODO: Fix and enable
    func test_init_UnicodeScalarLiteral() throws {

        let wand: Wand.Core = "䷓"

        XCTAssertEqual(wand.get(), "䷓")
        XCTAssertNotNil(wand)

    }

    func test_init_Context() throws {

        //TODO: Add URL.any
        let context = URLRequest(url: Bundle.main.bundleURL)

        let wand = Core.to(context)

        XCTAssertEqual(wand.get(), context as URLRequest)
        XCTAssertNotNil(wand)

    }

}
