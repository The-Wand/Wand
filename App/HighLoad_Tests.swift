///
/// Copyright 2020 Aleksander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Aleksander Kozin
/// The Wand

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
