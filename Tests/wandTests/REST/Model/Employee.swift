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
//
//import Wand
//
//import Foundation
//
//struct Employee: DummyRestAPIModel {
//
//    let id: Int?
//
//    let age: Int?
//    let name: String?
//    let salary: Int?
//
//    init(id: Int? = nil,
//         age: Int? = nil,
//         name: String? = nil,
//         salary: Int? = nil) {
//
//        self.id = id
//        self.age = age
//        self.name = name
//        self.salary = salary
//    }
//
//    func post<P>(with piped: P, on pipe: Pipeline) {
//
//        //dummy.restapiexample.com/api/v1/create
//
//        let path = Self.base + "create"
//        pipe.put(path)
//
//        let body: Data = self|
//        pipe.put(body)
//
//    }
//
//    func put<P>(with piped: P, on pipe: Pipeline) {
//
//        //dummy.restapiexample.com/api/v1/update/21
//
//        let path = Self.base + "update/" + id|
//        pipe.put(path)
//
//        let body: Data = self|
//        pipe.put(body)
//
//    }
//
//}
