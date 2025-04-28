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

        let e = expectation(description: "event.any")
        e.assertForOverFulfill = false

        let wand = Vector.every | String.every

        var handlePerformance: Performance!
        Performance.measure(of: "Ask<Any> add") {

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
        _ = wand.store(the: ask)
        return wand
    }

}
