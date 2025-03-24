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

/// Get Object from Wand 
/// or create in Context
/// 
/// TODO: func |(wand: Wand?) -> Self
public
protocol Obtainable: Wanded {

    @inline(__always)
    static 
    func obtain(by wand: Wand?) -> Self

}

/// Obtainable
///
/// let object = T|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(type: T.Type) -> T {
    T.obtain(by: nil)
}

/// Obtainable
///
/// let object: T = wand|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(wand: Wand?) -> T {
    wand?.get() ?? {
        let object = T.obtain(by: wand)
        return wand?.add(object) ?? object
    }()
}

/// Obtainable
///
/// let object: T = wand.obtain()
///
extension Wand {

    @inline(__always)
    public
    func get<T: Obtainable> (for key: String? = nil) -> T {
        get(for: key, or: T.obtain(by: self))
    }
    
}

/// Obtainable
///
/// let object: T = context|
///
@inline(__always)
postfix
public
func |<C, T: Obtainable>(context: C) -> T {
    context as? T ?? Wand.to(context).get()
}

/// Obtainable unwrap
///
/// let option: T? = nil
/// let object = option|
///
@inline(__always)
postfix
public
func |<T: Obtainable> (object: T?) -> T {
    object ?? T.self|
}
