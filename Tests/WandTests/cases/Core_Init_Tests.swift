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

class Core_Init_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_init_Nil() throws {

        let value: Int? = nil

        let wand: Wand.Core = .to(value)
        XCTAssertNotNil(wand)

    }

    func test_init_NilLiteral() throws {

        let wand: Wand.Core = nil
        XCTAssertNotNil(wand)
        
    }

//    func test_init_Array() throws {
//        Core(array: context)
//    }
//
//    func test_init_ArrayLiteral() throws {
//        Core(array: context)
//    }
//
//    func test_init_Dictionary() throws {
//        Core(dictionary: context)
//    }
//
//    func test_init_DictionaryLiteral() throws {
//        Core(dictionary: context)
//    }
//
//    func test_init_FloatLiteral() throws {
//    }
//
//    func test_init_StringLiteral() throws {
//    }
//
//    func test_init_BooleanLiteral() throws {
//    }
//
//    func test_init_IntegerLiteral() throws {
//    }
//
//    func test_init_StringInterpolation() throws {
//    }
//
//    func test_init_UnicodeScalarLiteral() throws {
//    }
//
//    func test_init_ExtendedGraphemeClusterLiteral() throws {
//    }
//
//    func test_init_Context() throws {
//        Core(for: context)
//    }

}
