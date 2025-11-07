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

infix   operator & : MultiplicationPrecedence

//@inlinable
//public
//func &<T, U> (ask: Ask<T>, handler: @escaping (U)->() ) -> Ask<T> {
//
//}

@inline(__always)
public
func &<T> (ask: Ask<T>, handler: @escaping (T)->() ) -> Ask<T> {
    ask & .one(handler: handler)
}

@inline(__always)
public
func &<T> (ask: Ask<T>, asks: Ask<T> ) -> Ask<T> {

    let saved = ask.handler
    ask.handler = {
        saved($0) && asks.handler($0)
    }

    return ask
}

@inline(__always)
public
func &<T> (handler: @escaping (T)->(), appending: @escaping (T)->() ) -> Ask<T> {
    Ask.one(handler: handler) & Ask.one(handler: appending)
}
