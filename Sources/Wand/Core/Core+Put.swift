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

/// Save objects
/// Without triggering Asks
extension Core {

    @inline(__always)
    public //#49 `default` ?
    func putDefault<T>(_ object: @autoclosure ()->(T), for raw: String? = nil) {

        let key = raw ?? T.self|
        if !contains(for: key) {
            self + object() ^ key
        }
    }

}

@discardableResult
@inline(__always)
public
func +<T>(wand: Core, object: T) -> T {

    Core[object] = wand
    wand.scope[T.self|] = object

    return object
}

@discardableResult
@inline(__always)
public
func +<T>(wand: Core, raw: (T, String)) -> String {

    let key = raw.1
    let object = raw.0

    Core[object] = wand
    wand.scope[key] = object

    return key
}

@discardableResult
@inline(__always)
public
func ^<T>(object: T, key: String?) -> (T, String) {
    (object, key ?? T.self|)
}

@discardableResult
@inline(__always)
public
func +<T>(wand: Core, raw: (String, T)) -> T {

    let key = raw.0
    let object = raw.1

    Core[object] = wand
    wand.scope[key] = object

    return object
}

@discardableResult
@inline(__always)
public
func ^<T>(key: String?, object: T) -> (String, T) {
    (key ?? T.self|, object)
}

@inline(__always)
public
func +<T>(wand: Core?, raw: (T, String)) {
    guard let wand else {
        return
    }

    let object = raw.0

    Core[object] = wand
    wand.scope[raw.1] = object
}

@discardableResult
@inline(__always)
public
func +<T>(wand: Core?, object: T) -> T? {
    guard let wand else {
        return nil
    }

    Core[object] = wand
    wand.scope[T.self|] = object

    return object
}


/// Save sequence
/// Without triggering Asks
extension Core {

    @inlinable
    public
    func dynamicallyCall<T>(withKeywordArguments args: T) where T == KeyValuePairs<String, Any> {
        for (key, object) in args {

            let type = type(of: object)
            if type is AnyClass {
                Core[object as AnyObject] = self
            }

            scope[key] = object
        }
    }

    @inlinable
    public
    func dynamicallyCall(withArguments objects: [Any]) {
        put(sequence: objects)
    }

    @inlinable
    public
    func put<T>(sequence: T) where T == any Sequence {
        sequence.forEach { object in

            let type = type(of: object)
            if type is AnyClass {
                Core[object as AnyObject] = self
            }

            scope[type|] = object
        }
    }

}
