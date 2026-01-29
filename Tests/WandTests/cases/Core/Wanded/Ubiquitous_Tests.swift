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

#if canImport(Foundation.NSData)
import Foundation.NSURLCache
import Testing
import Wand

fileprivate
var sharedCache: URLCache {
    URLCache.shared
}

extension URLCache: @retroactive Ubiquitous {

    public
    static
    func access() -> Self {
        URLCache.shared as! Self
    }

}

@Test
func ubiquitous_from_core()
{
    let object: URLCache = Core().get()
    #expect(object == sharedCache)
}

@Test
func ubiquitous_from_core_optional()
{
    let wand: Core? = nil

    let object: URLCache = wand|
    #expect(object == sharedCache)
}

@Test
func ubiquitous_from_scope_cast()
{
    let object: Any = sharedCache
    let ubiquitous: URLCache = object|

    #expect(object as? URLCache == ubiquitous)
}

@Test
func obtain_from_scope_access()
{
    let object = String.any
    let obtained: URLCache = object|

    #expect(obtained == sharedCache)
}

@Test
func ubiquitous_from_type()
{
    let obtained = URLCache.self|
    #expect(obtained == sharedCache)
}

@Test
func ubiquitous_unwrap()
{
    let object: URLCache? = sharedCache
    let obtained: URLCache = object|

    #expect(obtained == sharedCache)
}

@Test
func ubiquitous_unwrap_type()
{
    let object: URLCache? = nil
    let obtained: URLCache = object|

    #expect(obtained == sharedCache)
}

@Test
func ubiquitous_default_setter()
{
    let memory = 42 * 1024 * 8
    let disk = memory * memory

    let cache = URLCache(memoryCapacity: memory, diskCapacity: disk)

    #expect(|cache == cache)
}

#endif
