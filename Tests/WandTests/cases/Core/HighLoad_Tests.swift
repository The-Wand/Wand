//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

import Foundation
import Testing
import Wand

struct Highload {

    /// Core 3.0.1
    /// A2485 | M1 Pro 16 Gb | macOS 15.6.1
    /// -logs ~380
    ///
    /// 🏎️ Launching 150m cores: ~900s
    /// 🏎️ Fulfilling 150m handlers: ~2400s
    ///
    /// 🏎️ Launching 111m cores: 384.420s
    /// 🏎️ Fulfilling 111m handlers: 482.9533100s
    @Test
    func highload_tests()
    {
        let count = 111_111_111
        let message = 0x1F408
        let tool = Tool()

        var core: Core? = |{ (point: Point) in
            tool.send(message: message, to: point, index: 0)
        }

        var nextCore = core

        Performance.measure("Launching \(count) cores") {

            (1...count).forEach { index in

                let newWand = |{ (point: Point) in
                    tool.send(message: message, to: point, index: index)
                }

                nextCore?.put(Core.Weak(item: newWand), for: "Wand")
                nextCore = newWand

                tool.send(index: index)
            }
        }

        nextCore = core
        core = nil

        Performance.measure("Fulfilling \(count) handlers") {

            nextCore?.add(Point.any)

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                wand.add(Point.any)
                nextCore = wand
            }
        }

        #expect(true)
    }

}
