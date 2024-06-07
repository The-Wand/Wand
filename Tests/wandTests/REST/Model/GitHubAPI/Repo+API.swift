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

import WandURL
import Wand

extension GitHubAPI.Repo: GitHubAPI.Model {    

    public 
    static
    var path: String {
        base! + "repositories"
    }

}

/// Get Model
/// 
/// 42 | .get { (repo: Repo) in
///
/// }
///
@discardableResult
func |(id: Int,
       get: Ask<GitHubAPI.Repo>.Get) -> Wand {

    let wand: Wand = nil

    let path = GitHubAPI.Repo.path + "/\(id)"
    wand.save(path)
    wand.save(Rest.Method.GET)

    return wand | get
}

/// Get Model
///
/// |.get { (repos: [Repo]) in
///
/// }
///
//@discardableResult
//prefix func |(get: Ask<[GitHubAPI.Repo]>.Get) -> Wand {
//
//    let wand = Wand()
//
//    let path = GitHubAPI.Repo.path
//    wand.save(path)
//
//    wand.save(Rest.Method.GET)
//
//    return wand | get
//}
//
///// Get Model
/////
///// query | .get { (repos: [Repo]) in
/////
///// }
/////
//@discardableResult
//func |(query: String,
//       get: Ask<[GitHubAPI.Repo]>.Get) -> Wand {
//
//    let wand = Wand()
//
//    let path = GitHubAPI.Repo.path + "?q=\(query)"
//    wand.save(path)
//
//    wand.save(Rest.Method.GET)
//
//    return wand | get
//}
