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

import Testing
import Wand

struct Numbers {

    @Test
    func test_Bool_to_Numeric() {
        #expect(true| == 1)
        #expect(false| == 0)
    }

    @Test
    func test_BinaryFloatingPoint_to_Int() {

        let value = Float(Int.any)
        let int: Int = value|

        #expect(int == Int(value))
    }

    @Test
    func test_BinaryInteger_to_Double() {

        let value: Int8 = .any
        let double: Double = value|

        #expect(double.isEqual(to: Double(value)))
    }

    @Test
    func test_BinaryInteger_to_Int() {

        let value: Int8 = .any
        let numeric: Int = value|

        #expect(numeric == value)
    }

    @Test
    func test_Double_to_Float() {

        let value: Double = .any
        let float: Float = value|

        #expect(float.isEqual(to: Float(value)))
    }

    @Test
    func test_BinaryInteger_to_String() {

        let value: Int16 = .any
        let string: String = value|

        #expect(string == value.description)

        #expect((nil as Int32?)| == nil)
    }

}
