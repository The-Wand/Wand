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

struct Strings {

    @Test
    func test_String_to_Int_numbers() {

        let sample = "12345"
        let int: Int? = 12345

        #expect(sample| == int)
    }

    @Test
    func test_String_to_Int_filtration() {

        let sample = "asadas12345__ qqw d3"
        let int: Int? = 123453

        #expect(sample| == int)
    }

    @Test
    func test_String_to_Double() {

        let sample = "42.0"
        let double: Double = 42.0

        #expect((sample|)?.isEqual(to: double) == true)
    }

    @Test
    func test_String_to_Data() {

        let sample = Data([72, 101, 108, 108, 111, 44, 32, 119, 97, 110, 100, 33])
        let data: Data? = "Hello, wand!"|

        #expect(data! == sample)
    }

}
