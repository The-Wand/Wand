//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

#if canImport(Foundation)
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

extension URLCache {

    @inline(__always)
    @discardableResult
    prefix
    public
    static
    func | (the: URLCache) -> Self {
        URLCache.shared = the
        return the as! Self
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
func ubiquitous_from_context_cast()
{
    let object: Any = sharedCache
    let ubiquitous: URLCache = object|

    #expect(object as? URLCache == ubiquitous)
}

@Test
func obtain_from_context_access()
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
func ubiquitous_setter()
{
    let original = URLCache.self|
    #expect(sharedCache == original)

    let memory = 42 * 1024 * 8
    let disk = memory * memory

    |URLCache(memoryCapacity: memory, diskCapacity: disk)

    let setted = URLCache.self|
    #expect(sharedCache == setted)
    #expect(setted.diskCapacity == disk)
    #expect(setted.memoryCapacity == memory)
}

#endif
