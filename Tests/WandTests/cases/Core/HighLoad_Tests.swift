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

    /// Core 3.0.1
    /// A2485 | M1 Pro 16 Gb | macOS 15.6.1
    /// -logs ~380
    ///
    /// 🏎️ Launching 150m cores: ~900s
    /// 🏎️ Fulfilling 150m handlers: ~2400s
    ///
    /// 🏎️ Launching 111m cores: ~300s
    /// 🏎️ Fulfilling 111m handlers: ~460s
    @Test
    func highload_tests()
    {
        let count = 111_11//1_111
        let message = 0x1F408
        let tool = Tool()

        var core: Core? = |{ (point: Point) in
            tool.send(message: message, to: point, index: 0)
        }

        var nextCore = core

        Performance.measure("Launching \(count) cores") {

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

        Performance.measure("Fulfilling \(count) handlers") {

            nextCore?.add(Point.any)

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                wand.add(Point.any)
                nextCore = wand
            }
        }

        #expect(true)
    }



//    🏎️ Launching 11111 cores
//    : 0.0277169
//    🏎️ Fulfilling 11111 handlers
//    0
//    : 0.0349998

//    🏎️ Launching 11111 cores
//    : 0.0279210
//    🏎️ Fulfilling 11111 handlers
//    0
//    : 0.0352640
//|



//    0.0273636
//    0.035012
    
//    🏎️ Launching 11111 cores
//    : 0.0278430
//    🏎️ Fulfilling 11111 handlers
//    0
//    : 0.0365388

//    🏎️ Launching 11111 cores
//    : 0.0270190
//    🏎️ Fulfilling 11111 handlers
//    0
//    : 0.0344501

//    🏎️ Launching 11111 cores
//    : 0.0272288
//    🏎️ Fulfilling 11111 handlers
//    0
//    : 0.0340471

    @Test func int_pointer() {

        var locs = [CLLocation]()
        (1...500_500).forEach { _ in
            let location = CLLocation(coordinate: .any,
                                      altitude: .any,
                                      horizontalAccuracy: .any,
                                      verticalAccuracy: .any,
                                      timestamp: .any)
            locs.append(location)
        }

        Performance.measure("bitCast") {
            locs.forEach {

                let address: Int = ($0 as AnyObject)|
//                print(address)
            }
        }

        Performance.measure("unsafeCast") {
            locs.forEach {

                let address: Int = $0|
//                print(address)
            }
        }

    }

}
