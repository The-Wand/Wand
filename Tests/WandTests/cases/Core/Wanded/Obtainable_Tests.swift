//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

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

//@Test
//func try_get_core_from_value_type()
//{
//    let object = String.any
//
//    let wand = Core[object]
//    #expect(wand == nil)
//}
