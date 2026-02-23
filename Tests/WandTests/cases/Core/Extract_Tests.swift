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
func extract_object()
{
    let wand = Core(String.any)
    #expect(wand.extract() == String.any)
}

@Test
func extract_not()
{
    let wand = Core()
    #expect(wand.extract() == String?.none)
}

@Test
func extract_object_notT()
{
    let wand = Core()
    wand.add("Point", for: "Point")

    wand |? { (error: Error) in
        #expect(error.code == -1)
    }

    let point: Point? = wand.extract()

    #expect(point == nil)
}
