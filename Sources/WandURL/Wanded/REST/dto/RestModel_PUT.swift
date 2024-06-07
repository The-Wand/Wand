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
/// dto | .put { (done: DTO) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public 
func |<T: Rest.Model> (dto: T, put: Ask<T>.Put) -> Wand {

    let wand: Wand = nil

    let path = T.path
    wand.save(path)

    let body: Data = try! JSONEncoder().encode(dto)
    wand.save(body)

    return wand | put
}

/// Ask
///
/// wand | .post { (done: T) in
///
/// }
///
@available(visionOS, unavailable)
@inline(__always)
@discardableResult
public 
func |<T: Rest.Model> (wand: Wand, put: Ask<T>.Put) -> Wand {

    wand.save(Rest.Method.PUT)

    _ = wand.answer(the: put)
    return wand | .one { (data: Data) in

        let model: T = wand.get()!
        wand.add(model)

    }

}

#endif
