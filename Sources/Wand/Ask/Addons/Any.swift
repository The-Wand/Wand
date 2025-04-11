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

import Foundation

/// Notify about <#Any#> object
///
/// wand | .any { any in
///
/// }
///
extension Ask {
    
    /// .any
    @inline(__always)
    public
    static
    func any(handler: @escaping (Any)->() ) -> Ask<Any> {
        .Option(once: false) {
            handler($0)
        }
    }

}

/// Add any object handler
@inline(__always)
@discardableResult
public
func |(wand: Core, any: Ask<Any>) -> Core {
    _ = wand.answer(the: any)
    return wand
}
