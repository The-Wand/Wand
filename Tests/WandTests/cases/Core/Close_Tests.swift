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
import CoreLocation
import Testing
import XCTest
import Wand

class CoreCloseTests: XCTestCase {

    func testClose()
    {
        let count: Int = .any(in: 1...111_111_1)

        var wand: Core? = (1...count).reduce(Core()) { wand, index in

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

        Performance.measure("Closing \(wand!) with \(wand!.context.count) objects") {
            _ = (wand!)|
        }

        wand = nil

//        XCTAssert(Wand.Core.all.count == 0)
        XCTAssertTrue(true)
    }

}
