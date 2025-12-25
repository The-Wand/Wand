///
/// Copyright 2020 Aleksander Kozin
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

/// Get object from Core
/// or create in context
///
/// TODO: func |(wand: Core?) -> Self
public
protocol Obtainable: Wanded {

    @inline(__always)
    static 
    func obtain(by wand: Core?) -> Self

}

/// Obtain
///
/// let object = T|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(type: T.Type) -> T {
    T.obtain(by: nil)
}

/// Obtain from wand
///
/// let object: T = wand|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(wand: Core?) -> T {
    wand?.get() ?? {
        
        let object = T.obtain(by: wand)
        return wand?.add(object) ?? object
    }()
}

/// Obtain from context
///
/// let object: T = context|
///
@inline(__always)
postfix
public
func |<C, T: Obtainable>(context: C) -> T {
    context as? T ?? Core.to(context).get()
}

/// Obtainable unwrap
///
/// let option: T? = nil
/// let object = option|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(object: T?) -> T {
    object ?? T.self|
}

/// Obtain from wand
///
/// let object: T = wand.get()
///
extension Core {
    
    @inline(__always)
    public
    func get<T: Obtainable>(for key: String? = nil) -> T {
        get(for: key, or: T.obtain(by: self))
    }
    
}
