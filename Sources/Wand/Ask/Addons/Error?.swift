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

/// Handle Error and Success
///
/// wand | { (error: Error?) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(wand: Core, handler: @escaping (Error?)->() ) -> Core {
    wand | .every(handler: handler)
}

/// Handle Error and Success
///
/// wand | .one { (error: Error?) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |(wand: Core, ask: Ask<Error?>) -> Core {

    //Handle Succeed completion
    let all = Ask.all { _ in
        _ = ask.handler(nil)
    }
    
    //Handle Error completion
    let error = Ask<Error>.Option(once: ask.once) {
        all.cancel()
        return ask.handler($0)
    }

    //Handle Error completion
    return wand | all | error

}
