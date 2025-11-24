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
    /// Core 3.0.0
    /// A2485 | M1 Pro 16 Gb | macOS 15.6.1
    /// -logs ~380
    /// 2_111_111 2297.079 seconds.
    /// 4_111_111 8606.619 seconds.
    /// 20 Nov 2025
    @Test
    func highload_tests()
    {

        let tool = Tool()

        var wands = (1...4_111_111).map { _ in

            let core = |{ (point: Vector) in
                tool.handle(point: point)
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
