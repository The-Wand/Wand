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

    /// Debug Highload
    /// Core 3.0.0
    /// A2485 | M1 Pro 16 Gb | macOS 15.6.1
    /// -logs ~380
    /// 2_111_111 2297.08 seconds.
    /// 4_111_111 8606.62 seconds.
    /// 20 Nov 2025
    ///
    /// 🏎️ Launching 150m cores : 1098.95
    @Test
    func highload_tests()
    {
        let count = 150//_000_000
        let message = "|?&"
        let tool = Tool()

        var cores = [Int: Core.Weak](minimumCapacity: count)

        Performance.measure("Launching \(count) cores") {

            (0...count).forEach {

                let wand = |{ (point: Point) in
                    tool.send(message: message, to: point)
                }

                cores[$0] = Core.Weak(item: wand)

                examine(value: cores.count, every: 500_000)
            }
        }

        Performance.measure("Fulfilling \(count) handlers") {

            while let item = cores.randomElement() {

                weak
                var wand = cores.removeValue(forKey: item.key)?.item

                #expect(wand != nil)
                wand?.add(Point.any)
                #expect(wand == nil)

                examine(value: cores.count, every: 10_000)
            }

        }

        #expect(cores.isEmpty)
    }

    @inline(__always)
    func examine(value: Int, every: Int) {
        if value % every == 0 {
            print(value)
        }
    }

}

//struct Node<T> {
//
//    var next: Self?
//    var object: T?
//
//    func item(at index: Int) -> T {
//
//        var node: Self
//        (0...index).forEach {
//
//            if $0 == index {
//                return object
//            } else {
//                node = self
//            }
//            
//        }
//    }
//
//}
//
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

