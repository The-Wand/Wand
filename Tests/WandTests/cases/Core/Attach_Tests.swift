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
func attach_core_to_nil()
{
    let object: Any? = nil

    let wand = Core[object]
    #expect(wand == nil)
}

@Test
func try_get_core_from_value_type()
{
    let object = String.any

    let wand = Core[object]
    #expect(wand == nil)
}

#if canImport(CoreLocation)
import CoreLocation.CLLocation

@Test
func get_dont_attached_core()
{
    let object = CLLocation.any

    let wand = Core[object]
    #expect(wand == nil)
}

@Test
func attach_core_to_object()
{
    let object = CLLocation.any

    let initialWand = Core()
    Core[object] = initialWand

    let wand = Core[object]
    #expect(wand === initialWand)
}

@Test
func attach_core_to_optional()
{
    let object: CLLocation? = .any

    let initialWand = Core()
    Core[object] = initialWand

    let wand = Core[object]
    #expect(wand === initialWand)
}

#endif
