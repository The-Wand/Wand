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

#if canImport(Foundation)
import Foundation
import Wand

/// Ask
///
/// wand | .get { (model: Rest.Model) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public 
func |<T: Rest.Model> (wand: Wand, get: Ask<T>.Get) -> Wand {

    if (wand.get() as String?) == nil {
        let path = T.path
        wand.save(path)
    }
    
    wand.store(Rest.Method.GET)

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
                let reply = try JSONDecoder().decode(T.self, from: data)
                wand.add(reply) //TODO: remove c-p RestModel_GET_Array

            }} catch(let e) {

                wand.add(e)

            }
    }

}

/// Ask
///
/// context | .get { (model: Rest.Model) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public 
func |<C, T: Rest.Model> (context: C?, get: Ask<T>.Get) -> Wand {
    Wand.to(context) | get
}

#endif
