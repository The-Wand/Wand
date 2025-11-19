///
/// Copyright 2020 Alexander Kozin
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
/// Created by Alex Kozin
/// El Machine 🤖

import Any_
import Wand

struct Vector: Equatable, Any_ {

    let x, y, z, t: UInt64

    public
    static
    var any: Self {
        .init(x: .any, y: .any, z: .any, t: .any(in: 0...5))
    }

}

extension Vector: Expecting, Wanded {

}

//Example of conforming to Asking
//Can be at least Expecting
extension String: @retroactive Expecting {

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
//struct Vector2: AskingNil {
//
//    var request: ( ()->() )? {
//        didSet {
//            request?()
//        }
//    }
//
//    public
//    static
//    func ask<C, T>(with context: C, ask: Wand.Ask<T>) -> Core {
//
//        let wand = Core.to(context)
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
//    func `try`<C>(with context: C, wand: Core) {
//
//
//    }
//
//}


