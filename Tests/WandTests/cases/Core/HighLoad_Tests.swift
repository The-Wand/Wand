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
        let count = 11_000_000
        let message = "|?&"

        let tool = Tool()

//        var wands: [Core.Weak]!
//        Performance.measure("Launching \(count) cores") {
//
//            wands = (1...count).map { _ in
//
//                let core = |{ (point: Point) in
//                    tool.send(message: message, to: point)
//                }
//
//                return Core.Weak(item: core)
//            }
//
//        }
//
//        Performance.measure("Fulfilling \(count) handlers") {
//
//            while !wands.isEmpty {
//
//                guard let index = (0..<wands.count).randomElement() else {
//                    return
//                }
//
//                let weak = wands[index]
//
//                weak
//                var wand = weak.item
//
//                let point = Point.any
//                wand?.add(point)
//
//                #expect(wand == nil)
//                wands.remove(at: index)
//
//                if index % 1000 == 0 {
//                    print(index)
//                }
//            }
//
//        }

        #expect(Wand.Core.all.isEmpty)
    }

}

//struct Node<T> {
//
//    var next: Self?
//    var object: T?
//
//}

//func a() {
//
//
//    var wand: Node<Core> = Node()
//
//    (1...count).forEach { _ 0
//
//        let core = |{ (point: Point) in
//            tool.send(message: message, to: point)
//        }
//
//        wand?.object = core
//
//        wand?.next = Node()
//        wand = wand?.next
//    }
//
//}

