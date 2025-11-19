//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

import Testing
import Wand

struct Highload {

    /// Debug Highload
    @Test
    func highload_tests()
    {
        var wands = (1...1_111_111).map { _ in

            let core = |{ (point: Vector) in

            }

            return Core.Weak(item: core)
        }

        while !wands.isEmpty {

            guard let index = (0..<wands.count).randomElement() else {
                return
            }

            let weak = wands[index]

            weak
            var wand = weak.item

            let point = Vector(x: .any,
                               y: .any,
                               z: .any,
                               t: .any)
            wand?.add(point)

            #expect(wand == nil)
            wands.remove(at: index)
        }

        #expect(Wand.Core.all.isEmpty)
    }

}
