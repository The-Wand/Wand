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
import CoreLocation.CLLocation

import Wand
import XCTest

class Wand_Put_Tests: XCTestCase {

    weak
    var wand: Core?

    func test_put() throws {

        var wand: Core! = Core()
        self.wand = wand

        let `struct` = CLLocationCoordinate2D.any
        wand.add(`struct`)

        let custom_struct = Custom(bar: .any)
        wand.add(custom_struct)

        let `class` = wand.add(CLLocation.any)

        let custom_class = CustomClass()
        custom_class.bar = .any
        wand.add(custom_class)

        // wanded equals original
        let wanded_struct: CLLocationCoordinate2D = try XCTUnwrap(wand.get() )
        XCTAssertTrue(`struct`.latitude == wanded_struct.latitude &&
                      `struct`.longitude == wanded_struct.longitude)

        let wanded_custom_struct: Custom = try XCTUnwrap(wand.get())
        XCTAssertTrue(custom_struct.bar == wanded_custom_struct.bar)

        XCTAssertEqual(`class`, wand.get())

        let wanded_custom_class: CustomClass = try XCTUnwrap(wand.get())
        XCTAssertIdentical(custom_class, wanded_custom_class)

        //Close wand
        weak
        var closed = wand|
        wand = nil

        XCTAssertNil(closed)
        XCTAssertNil(self.wand)

    }
    
//    func test_put_Sequense() throws {
//        
//        var wand: Core! = Core()
//        self.wand = wand
//        
//        let bool = true
//        let int = 4
//        let location = CLLocation.any
//        let date = Date.any
//        
//        let sequence: [Any] = [bool, int, location, date]
//        wand.put(sequence: sequence)
//        
//        XCTAssertEqual(wand.get(), bool)
//        XCTAssertEqual(wand.get(), int)
//        XCTAssertEqual(wand.get(), location)
//        XCTAssertEqual(wand.get(), date)
//        
//        // wand is the same
//        XCTAssertTrue(wand === (location as Optional).wand)
//        XCTAssertTrue(wand === (date as Optional).wand)
//        
//        //Close wand
//        weak
//        var closed = wand|
//        wand = nil
//        
//        XCTAssertNil(closed)
//        XCTAssertNil(self.wand)
//        
//    }
    
    func test_put_Wanded() throws {
        
        var wand: Core! = Core()
        self.wand = wand

        let original: CLLocation = CLLocation.any
        wand.add(original)

        // wanded equals original
        let wanded: CLLocation = try XCTUnwrap(wand.get())
        XCTAssertEqual(original, wanded)

        // wand is the same
        XCTAssertTrue(wand === (wanded as Optional).wand)
        XCTAssertTrue((original as Optional).wand ===
                      (wanded as Optional).wand)

        //Close wand
        weak
        var closed = wand|
        wand = nil

        XCTAssertNil(closed)
        XCTAssertNil(self.wand)
        
    }

    func test_closed() throws {
        XCTAssertNil(wand)
    }

    private 
    struct Custom {
        var bar: Int
    }

    private 
    class CustomClass {
        var bar: Int?
    }

}
