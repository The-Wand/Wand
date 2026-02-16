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
/// or create in scope
public
protocol Obtainable: Wanded {

    static
    func obtain<C>(with scope: C?, by wand: Core?) -> Self

}

/// Obtain
///
/// let object = T|
///
@inline(__always)
postfix
public
func |<T: Obtainable>(type: T.Type) -> T {
    T.obtain(with: type, by: nil)
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

        let object = T.obtain(with: wand, by: wand)
        return wand?.add(object) ?? object
    }()
}

/// Obtain from scope
///
/// let object: T = scope|
///
@inline(__always)
postfix
public
func |<C, T: Obtainable>(scope: C) -> T {
    scope as? T ?? T.obtain(with: scope, by: nil)
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
        get(for: key, or: T.obtain(with: key, by: self))
    }

}
