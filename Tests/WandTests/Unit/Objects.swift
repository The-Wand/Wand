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
/// Created by Alek Kozin
/// El Machine 🤖

import Any_
import Wand

struct Point: Equatable {

    let x, y, z, t: Int64

}

extension Point: Expecting, Wanded {

}

extension Point: Any_ {

    public
    static
    var any: Self {
        .init(x: .any, y: .any, z: .any, t: .any)
    }

}

//Example of conforming to AskT
//Can be at least Expecting
extension String: @retroactive Expecting {

}

//Example of conforming to AskT
//Can be at least Expecting
//extension String: @retroactive AskT {}
//extension String: @retroactive AskNil {
//
//    @inline(__always)
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//        _ = wand.append(ask: ask)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
//            wand?.add("String.any")
//        }
//
//        return wand
//    }
//
//}

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

//    func didReceive(message: String, from point: Point) {
//
//        print(message)
//        
//        let isValid = true
//        if isValid {
//            handshake()
//        }
//    }
//
//    func handshake() {
//
//    }

}

//extension Ask {
//
//    public
//    var request: ( ()->() )? {
//        didSet {
//            request?()
//        }
//    }
//
//}
//
//struct Vector2: Ask.Nil {
//
//    var request: ( ()->() )? {
//        didSet {
//            request?()
//        }
//    }
//
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Wand.Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//
//        guard wand.append(ask: ask, check: true) else {
//            return wand
//        }
//
//
//        //Make request
//        ask.request = {
//
////            source.startUpdates(from: date) { (data, error) in
////                wand.addIf(exist: data)
////                wand.addIf(exist: error)
////            }
//        }
//
//        return wand
//    }
//
//    public
//    static
//    func `try`<C>(with scope: C, wand: Core) {
//
//
//    }
//
//}


