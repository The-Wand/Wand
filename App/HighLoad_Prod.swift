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

#if true

import Wand

public
struct Highload {

    /// Production Highload
    static
    public
    func highload_prod(of count: Int)
    {
        let message = 0x1F408
        let tool = Tool()

        var core: Core? = |{ (location: CLLocation) in
            tool.send(message: message, index: 0)
        }

        var nextCore = core

        Performance(of: "Launching \(count) cores") {

            (1...count).forEach { index in

                let newWand = |{ (point: Point) in
                    tool.send(message: message, index: index)
                }

                nextCore?.put(Core.Weak(item: newWand), for: "Wand")
                nextCore = newWand

                tool.send(index: index)
            }
        }

        nextCore = core
        core = nil

        Performance(of: "Fulfilling \(count) handlers") {

            nextCore?.add(Point.any)

            while let wand = (nextCore?.get(for: "Wand") as Core.Weak?)?.item {
                let lo🐱ation = Point.any
                wand.add(lo🐱ation)
                nextCore = wand
            }
        }

        assert(Wand.Core.all.isEmpty)
    }

}

import CoreLocation.CLLocation

extension CLLocation: AskNil {}
extension CLLocation: AskT {}
extension CLLocation: Expecting {

}


public
struct Point: Expecting, Equatable {

    let x, y, z, t: Int64

    public
    static
    var any: Self {
        .init(x: Int64(arc4random() % UInt32.max),
              y: Int64(arc4random() % UInt32.max),
              z: Int64(arc4random() % UInt32.max),
              t: Int64(arc4random() % UInt32.max))
    }

}

struct Tool {

    @inlinable
    func send(message: Int, to point: Point? = nil, index: Int) {
        send(index: index)
    }

    @inlinable
    func send(index: Int) {
        if index % 1_000_000 == 0 {
            print(index)
        }
    }

}

#endif
