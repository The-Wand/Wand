///
/// Copyright 2569 Aleksander Kozin
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
/// Created by Aleksander Kozin
/// The Wand

internal
import OrMacro

//TODO: Move to macros
//+Partially updated
extension KeyPath {
    
    @inline(__always)
    postfix
    public
    static
    func |(path: KeyPath) -> String {
        #om(path)
//        "\(path)".components(separatedBy: ".").last ?? ""
    }
    
}

extension KeyPath {
    
    @discardableResult
    @inline(__always)
    public
    static
    func &(object: Core?, key: KeyPath) -> (Core?, KeyPath) {
        (object, key)
    }
    
    @discardableResult
    @inline(__always)
    public
    static
    func &<T>(object: T?, key: KeyPath) -> (T?, KeyPath) {
        (object, key)
    }
    
}
