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
import CoreGraphics
import Wand

struct CoreGraphics {

    @Test
    func test_CGFloat_to_Float() {

        let value = CGFloat.any
        let float: Float = value|

        #expect(float.isEqual(to: Float(value)))
    }

    @Test
    func test_Int_CGFloat() {

        let value = Int.any
        let float: CGFloat = value|

        #expect(float.isEqual(to: CGFloat(value)))
    }

}
