//
//  Attach.swift
//  Wand
//
//  Created by Aleksander Kozin on 13/11/25.
//  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
//

import Foundation

private
struct Point: Expecting, Equatable {

    let x, y, z: UInt64
    let t: Int32

    public
    static
    var any: Self {
        .init(x: UInt64(arc4random() % UInt32.max),
              y: UInt64(arc4random() % UInt32.max),
              z: UInt64(arc4random() % UInt32.max),
              t: Int32(arc4random() % UInt32.max))
    }

}

public
struct Highload {

    /// Production Highload
    static
    public
    func highload_tests()
    {
        var wands = (1...1_111_111).map { _ in

            let core = |{ (point: Point) in

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

            let point = Point.any
            wand?.add(point)

            assert(wand == nil)
            wands.remove(at: index)
        }

        assert(Wand.Core.all.isEmpty)
    }

}
