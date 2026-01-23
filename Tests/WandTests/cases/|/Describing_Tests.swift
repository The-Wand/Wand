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

struct Describing {

    @Test
    func test_Character_to_Int() {
//TODO:        "\u{1111}" as Character
        let character: Character = "|"
        #expect(character| == 0x7C)
    }

    @Test
    func test_Int_toCharacter() {
        #expect("🐕" as Character == 0x1F415|)
    }

    @Test
    func test_Data_to_String() {

        let sample = Data([72, 101, 108, 108, 111, 44, 32, 119, 97, 110, 100, 33])
        let string: String? = sample|

        #expect("Hello, wand!" == string)
    }

}
