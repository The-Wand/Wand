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
import XCTest

import CoreLocation

struct Highload {

    private
    let count = 111_111_111

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
        let tool = Tool()

        var wand: Core = Core(id: 0x2715)
        wand | { (point: Point) in
            tool.send(object: Bot(), to: point, index: 0)
        }

        var next = wand

        Performance(of: "Opening \(count) cores") {
            
            (1...count).forEach { index in
                
                let bot = Bot()
                
                let newWand = bot.wand | { (point: Point) in //TODO: Remove C-P
                    tool.send(object: bot, to: point, index: index)
                }
                
                next + Core.Weak(item: next++) & "Wand"
                next = newWand
                
                tool.send(index: index)
            }
            
        }

        next = wand
        wand = nil

        Performance(of: "Fulfilling \(count) handlers") {

            next + Point.any

            while let wand = (next.get(for: "Wand") as Core.Weak?)?.item {
                wand + Point.any
                next = wand
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
            tool.send(object: Bot(message), index: 0)
        }

        var nextCore = core

        Performance(of: "Launching \(count) cores") {

            (1...count).forEach { index in

                let newWand = |{ (location: CLLocation) in
                    tool.send(object: Bot(message), index: index)
                }

                nextCore + Core.Weak(item: newWand) & "Wand"
                nextCore = newWand

                tool.send(index: index)
            }
        }

        nextCore = core
        core = nil

        Performance(of: "Fulfilling \(count) handlers") {

            nextCore + CLLocation.any

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                let lo🐱ation = CLLocation(coordinate: .any,
                                          altitude: .any,
                                          horizontalAccuracy: .any,
                                          verticalAccuracy: .any,
                                          timestamp: .any)
                wand + lo🐱ation
                nextCore = wand
            }
        }

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

class HighloadTests: XCTestCase {

    /// Core 3.0.2
    /// A2485 | M1 Pro 16 Gb | macOS 26.0.1
    /// -logs ~380
    ///
    /// 🏎️ Closing Wand 150m objects:
    ///
    /// 🏎️ Closing Wand 111m objects:
    func testClose()
    {
        let closeCount = 11//1_111_111 //🫵HM🫰
        let tool = Tool()

        var wand: Core? = (1...closeCount).reduce(Core()) { wand, index in

            let location = CLLocation(coordinate: .any,
                                      altitude: .any,
                                      horizontalAccuracy: .any,
                                      verticalAccuracy: .any,
                                      timestamp: .any)
            wand + location & index|

            tool.send(index: index)

            return wand
        }

        measure(metrics: .default) {
            wand|
        }

        Performance(of: "Closing \(wand!) with \(wand!.scope.count) objects") {
            _ = (wand!)|
        }

        wand = nil

        //        XCTAssert(Wand.Core.all.count == 0)
        XCTAssert(true)
    }

}

import CoreLocation.CLLocation

extension CLLocation: @retroactive AskNil {}
extension CLLocation: @retroactive AskT {}
extension CLLocation: @retroactive Expecting {

}
