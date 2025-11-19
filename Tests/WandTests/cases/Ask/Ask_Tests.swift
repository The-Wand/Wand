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
func ask_set_key()
{
    let ask = String.one

    ask.key = .any

    #expect(ask.key == .any)
}

@Test
func ask_set_key_not()
{
    let ask = String.one
    #expect(ask.key == "String")
}

@Test
func ask_cancel()
async
{
    let ask = String.one.fatal()

    let wand = |ask

    ask.cancel()

    wand.add(String.any)
    #expect(true)
}
