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
