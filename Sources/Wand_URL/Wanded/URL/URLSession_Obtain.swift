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
import Foundation.NSURLSession
import Wand

/// Obtain
///
/// let session: URLSession = config|
///
@available(visionOS, unavailable)
extension URLSession: Obtain {

    @inline(__always)
    public 
    static
    func obtain(by wand: Wand?) -> Self {

        let session: Self

        if let config: URLSessionConfiguration = wand?.get() {
            session = Self(configuration: config)
        } else {
            session = Self.shared as! Self
        }

        return session
    }

}

#endif

