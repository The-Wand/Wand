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
func add_object_if_exist()
{
    let wand = |{ (string: String) in
        #expect(string == .any)
    }

    let optional: String? = .any

    wand.addIf(exist: optional)

    #expect(wand.get() == optional)
}

@Test
func add_object_if_exist_not()
{
    let wand = |String.one.fatal()

    let optional: String? = nil

    wand.addIf(exist: optional)

    #expect(wand.get() == nil as String?)
}

