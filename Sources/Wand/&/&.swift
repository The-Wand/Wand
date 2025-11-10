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

infix   operator |& : MultiplicationPrecedence

@inline(__always)
public
func &<T: AskingNil> (handler: @escaping (T)->(), applying: Ask<T> ) -> Core { //Ask<T> {
    let ask = Ask.one {
        handler($0)
        _ = applying.handler($0)
    }

    let wand = Core()
    _ = wand.append(ask: ask)

    return wand
}

@inline(__always)
public
func &<T: AskingNil, U: Asking> (handler: @escaping (T)->(), applying: Ask<U> ) -> Ask<T> {
    Ask.one {
        handler($0)
//        applying.handler($0)
    }
}

//@inline(__always)
//public
//func &<T> (handler: @escaping (T)->(), appending: @escaping (T)->() ) -> Ask<T> {
//    Ask.one {
//        handler($0)
//        appending($0)
//    }
//}
//
//@inline(__always)
//public
//func &<T> (ask: Ask<T>, appending: @escaping (T)->() ) -> Ask<T> {
//    Ask(once: ask.once) { object in
//        defer {
//            appending(object)
//        }
//        return ask.handler(object)
//    }
//}
