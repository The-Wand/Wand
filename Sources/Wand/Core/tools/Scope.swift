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

@discardableResult
@inline(__always)
public
func ~=(wand: Core, key: String) -> Bool {
    wand.scope.keys.contains(key)
}

infix   operator !~= : ComparisonPrecedence

@discardableResult
@inline(__always)
public
func !~=(wand: Core, key: String) -> Bool {
    !(wand ~= key)
}

postfix operator -

@discardableResult
@inline(__always)
postfix
public
func -<T>(wand: Core) -> T? {
    wand - T.self|
}

@discardableResult
@inline(__always)
public
func -<T>(wand: Core, key: String?) -> T? {
    switch wand.scope.removeValue(forKey: key ?? T.self|) {
        case nil:
            nil
        case let object as T:
            object
        default:
            wand + Core.Error.with(code: -1, reason: "not T") as? T
    }
}
