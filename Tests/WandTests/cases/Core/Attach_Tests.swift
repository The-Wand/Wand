//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

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
