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
func extract_object()
{
    let wand = Core(String.any)
    #expect(wand.extract() == String.any)
}

@Test
func extract_object_not()
{
    let wand = Core()
    #expect(wand.extract() == String?.none)
}
