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

/// Asking
extension XCTestCase {

    func auto<C, T: Asking>(test context: C, completion:  @escaping (T)->() ) {
        auto(test: context, api: |, completion: completion)
    }

    func auto<C, T: Asking>(test context: C,
                            api: ( (C, (T)->()) )->(Core),
                            completion:  @escaping (T)->() ) {

        let e = expectation()
        e.assertForOverFulfill = true

        _ = api( (context, { (t: T) in
            e.fulfill()
            completion(t)
        }) )

        waitForExpectations(timeout: .default)
        
    }

}

/// AskingNil
extension XCTestCase {
    
    func auto_test<T: AskingNil>(completion:  @escaping (T)->() ) {
        auto_test(|, completion: completion)
    }

    func auto_test<T: AskingNil>(_ api:   ( @escaping (T)->() )->(Core) ,
                               completion:  @escaping (T)->() ) {

        let e = expectation()
        e.assertForOverFulfill = true

        _ = api({ (t: T) in
            e.fulfill()
            completion(t)
        })

        waitForExpectations(timeout: .default)

    }

}

/// Tools
extension XCTestCase {

    func expectation(function: String = #function) -> XCTestExpectation {
        expectation(description: function)
    }

    func waitForExpectations() {
        waitForExpectations(timeout: .default)
    }

}
