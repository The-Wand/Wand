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
func get_or_create()
{
    let wand = Core()
    let wanded = wand.get(or: String.any)
    #expect(wanded == .any)
}

@Test
func get_not_create()
{
    let string1 = "string1"

    let wand = Core(string1)

    let wanded = wand.get(or: "Never")
    #expect(wanded == string1)
}
