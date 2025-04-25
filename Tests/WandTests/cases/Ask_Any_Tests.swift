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

class Expect_Any_Tests: XCTestCase {

    func test_Any() throws {

        let e = expectation(description: "event.any")
        e.assertForOverFulfill = false

        var wand: Wand.Core!

        measure(metrics: .default) {

            wand = Vector.every | String.every | .any { _ in
                e.fulfill()
            }

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in

            //TODO: Update Any_
            if .random() {
                wand?.add(Vector.any)
            } else {
                wand?.add(String.any)
            }

        }

        waitForExpectations()
        
    }

    func test_Any_Performance() throws {

        //1
        //        🏎️ Ask<Any> add : 0.0007029
        //        🏎️ Ask<Any> handle : 0.0000870

        //        🏎️ Ask<Any> add : 0.0006747
        //        🏎️ Ask<Any> handle : 0.0004880

        //        🏎️ Ask<Any> add : 0.0007439
        //        🏎️ Ask<Any> handle : 0.0004399

        //        🏎️ Ask<Any> add : 0.0007453
        //        🏎️ Ask<Any> handle : 0.0001409

        //average add: 0,0007
        //average handle: 0,0003

//2


//        🏎️ Ask<Any> add : 0.0000079
//        🏎️ Ask<Any> handle : 0.0001211

//        🏎️ Ask<Any> add : 0.0000079
//        🏎️ Ask<Any> handle : 0.0002398

//        🏎️ Ask<Any> add : 0.0000079
//        🏎️ Ask<Any> handle : 0.0002649

        //average add: 0.000 008
        //average handle: 0,0002

//3
//        🏎️ Ask<Any> handle : 0.0001049
//        🏎️ Ask<Any> handle : 0.0003870
//        🏎️ Ask<Any> handle : 0.0001681

//        🏎️ Ask<Any> handle : 0.0003161
//        🏎️ Ask<Any> handle : 0.0000730
//        🏎️ Ask<Any> handle : 0.0002451
//        🏎️ Ask<Any> handle : 0.0003579

        //average handle: 0,0002360142857

        let e = expectation(description: "event.any")
        e.assertForOverFulfill = false

        let wand = Vector.every | String.every

        var handlePerformance: Performance!
        Performance.measurePerformance(of: "Ask<Any> add") {

            wand | .any { _ in

                handlePerformance.measure()

                e.fulfill()
            }

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in

            handlePerformance = Performance(of: "Ask<Any> handle")

            //TODO: Update Any_
            if .random() {
                wand?.add(Vector.any)
            } else {
                wand?.add(String.any)
            }

        }

        waitForExpectations()

    }

}

//Example of conforming to Asking
extension String: @retroactive Asking
{
    @inline(__always)
    public
    static
    func ask<C, T>(with context: C, ask: Ask<T>) -> Core {
        let wand = Wand.Core.to(context)
        _ = wand.answer(the: ask)
        return wand
    }

}
