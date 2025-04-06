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

class Describing_Tests: XCTestCase {

    func test_wand() throws {
        let char: Character = 0x7C|
        XCTAssertEqual("|", char)
    }

    func test_Any() throws {
        let char: Character = 0x5F|
        XCTAssertEqual("_", char)
    }

    func test_Data_to_String() throws {
        let sample = Data([72, 101, 108, 108, 111, 44, 32, 119, 97, 110, 100, 33])
        let string: String = sample|

        XCTAssertEqual("Hello, wand!", string)
    }

    func test_String_to_Data() throws {
        let sample = Data([72, 101, 108, 108, 111, 44, 32, 119, 97, 110, 100, 33])
        let data: Data? = "Hello, wand!"|

        XCTAssertEqual(data!, sample)
    }

}
