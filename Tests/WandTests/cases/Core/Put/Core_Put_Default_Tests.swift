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

@Test
func put_default()
{
    let string1 = "string1"
    let string2 = "string2"

    let wand = Core()
    wand(Key: string1)

    wand.putDefault(string2)

    #expect(wand.get() == string2)
    #expect(wand.get(for: "Key") == string1)
}

@Test
func put_default_not()
{
    let string1 = "string1"
    let string2 = "string2"

    let wand = Core(string1)

    wand.putDefault(string2)

    #expect(wand.get() == string1)
}
