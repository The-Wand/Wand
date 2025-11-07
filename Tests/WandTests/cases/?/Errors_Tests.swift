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

import Wand
import XCTest

class Errors_Tests: XCTestCase {

    func test_One_Error_Fail_Handling() throws {

        let e1 = expectation()
        let e2 = expectation()

        weak
        var wand: Core!
        wand = Vector.every | String.one { _ in
            fatalError()
        } | { (error: Error) in
            e1.fulfill()
        } | .all { _ in
            e2.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
            wand?.add(NSError() as Error)
        }

        wait(for: [e1, e2])
    }

}
