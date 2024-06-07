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


//import Foundation
//import UIKit.UIButton
//
////UIButton
//@discardableResult
//func | (path: String?, button: UIButton) -> Pipe {
//    guard
//        let path,
//        !path.isEmpty
//    else {
//        button.setImage(nil, for: .normal)
//        return Pipe()
//    }
//
//    return path | button
//}
//
////@discardableResult
////func | (path: String, button: UIButton) -> Pipe {
////    URL(string: path)! | button
////}
////
////@discardableResult
////func | (url: URL?, button: UIButton) -> Pipe {
////    button.kf.setImage(with: url, for: .normal)
////    return Pipe()
////}
////
////UIImageView
////@discardableResult
////func | (path: String?, imageView: UIImageView) -> Pipe {
////    guard
////        let path,
////        !path.isEmpty
////    else {
////        imageView.image = nil
////        return Pipe()
////    }
////
////    return path | imageView
////}
////
////@discardableResult
////func | (path: String, imageView: UIImageView) -> Pipe {
////    URL(string: path)! | imageView
////}
//
////@discardableResult
////func | (url: URL?, imageView: UIImageView) -> Pipe {
////    imageView.kf.setImage(with: url)
////    return Pipe()
////}
