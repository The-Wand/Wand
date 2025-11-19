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
func cleaner_set()
async
{
    let ask = String.one
    let wand = |ask

    var cleaned = false
    wand.setCleaner(for: ask) {
        cleaned = true
    }

    wand.add(String.any)

    #expect(cleaned)
}
