///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine
///

#if canImport(Foundation)
import Foundation
import Wand

/// Ask
///
/// wand | .get { (array: [Rest.Model]) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public
func |<T: Rest.Model> (wand: Wand, get: Ask<[T]>.Get) -> Wand {

    let wand: Wand = nil

    let path = T.path
    wand.save(path)
    wand.save(Rest.Method.GET)

    _ = wand.answer(the: get)

    return wand | .one { (data: Data) in
        do { if
                let method: Rest.Method = wand.get(),
                method != .GET,
                let object: T = wand.get()
            {
                wand.add(object)
            } 
            else
            {
                let reply = try JSONDecoder().decode([T].self, from: data)
                wand.add(reply) //TODO: remove c-p RestModel_GET

            }} catch(let e) {
                
                wand.add(e)

            }
    }

}

/// Ask
///
/// | { (array: [Rest.Model]) in
///
/// }
///
@available(visionOS, unavailable)
@discardableResult
@inline(__always)
prefix
public
func |<T: Rest.Model> (handler: @escaping ([T])->() ) -> Wand {
    nil | .get(handler: handler)
}

/// Ask
///
/// |.get { (array: [Rest.Model]) in
///
/// }
///
@available(visionOS, unavailable)
@discardableResult
@inline(__always)
prefix
public
func |<T: Rest.Model> (get: Ask<[T]>.Get) -> Wand {
    nil | get
}

/// Ask
///
/// context | { (array: [Rest.Model]) in
///
/// }
///
@available(visionOS, unavailable)
@discardableResult
@inline(__always)
public
func |<C, T: Rest.Model> (context: C?, handler: @escaping ([T])->() ) -> Wand {
    Wand.to(context) | .get(handler: handler)
}

/// Ask
///
/// context | .get { (array: [Rest.Model]) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public 
func |<C, T: Rest.Model> (context: C?, get: Ask<[T]>.Get) -> Wand {
    Wand.to(context) | get
}

public
extension Ask {//} where T == [any Rest.Model] {

    static
    func get(handler: @escaping (T)->() ) -> Get {
        .one(handler: handler)
    }

    static
    func post(handler: @escaping (T)->() ) -> Post {
        Post.one(handler: handler)
    }

    static
    func put(handler: @escaping (T)->() ) -> Put {
        .one(handler: handler)
    }

    static
    func delete(handler: @escaping (T)->() ) -> Delete {
        .one(handler: handler)
    }

}

#endif
