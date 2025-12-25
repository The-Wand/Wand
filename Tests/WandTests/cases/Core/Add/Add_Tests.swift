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
func add_object_if_exist()
{
    let wand = |{ (string: String) in
        #expect(string == .any)
    }

    let optional: String? = .any

    wand.addIf(exist: optional)

    #expect(wand.get() == optional)
}

@Test
func add_object_if_exist_not()
{
    let wand = |String.one.fatal()

    let optional: String? = nil

    wand.addIf(exist: optional)

    #expect(wand.get() == nil as String?)
}

