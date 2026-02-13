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

import Foundation
import Testing
import Wand

import CoreLocation

struct Highload {

    private
    let count = 111//_111_111

    /// Core 3.0.2
    /// A2485 | M1 Pro 16 Gb | macOS 26.0.1
    /// -logs ~380
    ///
    /// 🏎️ Launching   150m cores: ~900s
    /// 🏎️ Fulfilling  150m handlers: ~2400s
    ///
    /// 🏎️ Launching   111m cores: ~300s
    /// 🏎️ Fulfilling  111m handlers: ~450s
    @Test
    func struct_test()
    {
        let message = 0x1F408
        let tool = Tool()

        var core: Core? = |{ (point: Point) in
            tool.send(message: message, to: point, index: 0)
        }

        var nextCore = core

        Performance(of: "Opening \(count) cores") {
            
            (1...count).forEach { index in
                
                let newWand = |{ (point: Point) in
                    tool.send(message: message, to: point, index: index)
                }
                
                nextCore?.put(Core.Weak(item: newWand), for: "Wand")
                nextCore = newWand
                
                tool.send(index: index)
            }
            
        }

        nextCore = core
        core = nil

        Performance(of: "Fulfilling \(count) handlers") {

            nextCore?.add(Point.any)

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                wand.add(Point.any)
                nextCore = wand
            }

        }

        #expect(true)
    }

    /// Core 3.0.2
    /// A2485 | M1 Pro 16 Gb | macOS 26.0.1
    /// -logs ~380
    ///
    /// 🏎️ Launching   150m cores:
    /// 🏎️ Fulfilling  150m handlers:
    ///
    /// 🏎️ Launching   111m cores: ~300s
    /// 🏎️ Fulfilling  111m handlers: ~600s
    @Test
    func class_test()
    {
        let message = 0x1F408
        let tool = Tool()

        var core: Core? = |{ (location: CLLocation) in
            tool.send(message: message, index: 0)
        }

        var nextCore = core

        Performance(of: "Launching \(count) cores") {

            (1...count).forEach { index in

                let newWand = |{ (location: CLLocation) in
                    tool.send(message: message, index: index)
                }

                nextCore?.put(Core.Weak(item: newWand), for: "Wand")
                nextCore = newWand

                tool.send(index: index)
            }
        }

        nextCore = core
        core = nil

        Performance(of: "Fulfilling \(count) handlers") {

            nextCore?.add(CLLocation.any)

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                let lo🐱ation = CLLocation(coordinate: .any,
                                          altitude: .any,
                                          horizontalAccuracy: .any,
                                          verticalAccuracy: .any,
                                          timestamp: .any)
                wand.add(lo🐱ation)
                nextCore = wand
            }
        }

        #expect(true)
    }

    /// Core 3.0.2
    /// A2485 | M1 Pro 16 Gb | macOS 26.0.1
    /// -logs ~380
    ///
    /// 🏎️ Closing Wand 150m objects:
    ///
    /// 🏎️ Closing Wand 111m objects:
    @Test
    func testClose()
    {
        let closeCount = 3//_333_333

        var wand: Core? = (1...closeCount).reduce(Core()) { wand, index in

            let location = CLLocation(coordinate: .any,
                                      altitude: .any,
                                      horizontalAccuracy: .any,
                                      verticalAccuracy: .any,
                                      timestamp: .any)
            wand.add(location, for: index|)

            return wand
        }

        //TODO: Fix and enable
        //Can you see any results?
        //        measure {
        //            wand|
        //        }

        Performance(of: "Closing \(wand!) with \(wand!.scope.count) objects") {
            _ = (wand!)|
        }

        wand = nil

        //        XCTAssert(Wand.Core.all.count == 0)
        #expect(true)
    }

    /// Core 3.0.2
    /// A2485 | M1 Pro 16 Gb | macOS 26.0.1
    /// -logs ~380
    ///
    /// 🏎️ bitCast     150m objects:
    /// 🏎️ unsafeCast  150m objects:
    ///
    /// 🏎️ bitCast     111m objects:
    /// 🏎️ unsafeCast  111m objects:
    @Test
    func int_pointer()
    {
        let appendingCount = 3//_333_333

        var locs = [CLLocation]()
        (1...appendingCount).forEach { _ in
            let location = CLLocation(coordinate: .any,
                                      altitude: .any,
                                      horizontalAccuracy: .any,
                                      verticalAccuracy: .any,
                                      timestamp: .any)
            locs.append(location)
        }

        Performance(of: "bitCast") {
            locs.forEach {

                let address: Int = ($0 as AnyObject)|
                print("bitCast", address)
            }
        }

        Performance(of: "unsafeCast") {
            locs.forEach {

                let address: Int = $0|
                print("unsafeCast", address)
            }
        }

    }

}

import CoreLocation.CLLocation

extension CLLocation: @retroactive AskNil {}
extension CLLocation: @retroactive AskT {}
extension CLLocation: @retroactive Expecting {

}
