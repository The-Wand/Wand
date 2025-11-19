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
func contains_object()
{
    let wand = Core()
    wand(Key: String.any)

    #expect(wand.contains(for: "Key"))
}

@Test
func contains_object_not()
{
    let wand = Core()
    wand(Key: String.any)

    #expect(!wand.contains(for: "String"))
}
