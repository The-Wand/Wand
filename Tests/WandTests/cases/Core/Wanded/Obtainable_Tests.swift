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

#if canImport(Foundation)
import Foundation.NSNotification
import Testing
import Wand

fileprivate
let toObtain = NotificationCenter.default

extension NotificationCenter: @retroactive Obtainable {

    @inline(__always)
    public
    static
    func obtain(by wand: Core?) -> Self {
        toObtain as! Self
    }

}

@Test
func obtain_from_core()
{
    let obtained: NotificationCenter = Core().get()

    #expect(obtained == toObtain)
}

@Test
func obtain_from_core_get()
{
    let core = Core(toObtain)
    let obtained: NotificationCenter = core.get()

    #expect(obtained == toObtain)
}

@Test
func obtain_from_context_cast()
{
    let object: Any = toObtain
    let obtained: NotificationCenter = object|

    #expect(object as? NotificationCenter == obtained)
}

@Test
func obtain_from_context_obtain()
{
    let object = String.any
    let obtained: NotificationCenter = object|

    #expect(obtained == toObtain)
}

@Test
func obtain_from_type()
{
    let obtained = NotificationCenter.self|
    #expect(obtained == toObtain)
}

@Test
func obtain_unwrap()
{
    let object: NotificationCenter? = toObtain
    let obtained: NotificationCenter = object|

    #expect(object == obtained)
}

@Test
func obtain_unwrap_type()
{
    let object: NotificationCenter? = nil
    let obtained: NotificationCenter = object|

    #expect(obtained == toObtain)
}

#endif
