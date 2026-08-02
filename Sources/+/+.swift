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

/// Objects
@discardableResult
@inlinable
public
func +<T>(wand: Core, raw: (T, String) ) -> T {

    let object = raw.0
    let key = wand.save(object, for: raw.1)

    defer {
        //Handle Ask.any
        if let tail = wand.handlers[.any]?.last as? Ask<Any> {
            
            let head = tail.next
            wand.handle(object, head: head, tail: tail)
            tail.next = head
        }
    }
    
    //Answer the questions
    guard let stored = wand.handlers[key] else {
        return object
    }

    //From head
    if let tail = (stored.last as? Ask<T>)?.head(object) {
        //Save
        wand.handlers[key] = (tail, stored.cleaner)
    } else {
        //Clean
        stored.cleaner?()
        wand.handlers[key] = nil
    }

    return object
}

@discardableResult
@inline(__always)
public
func +<T>(wand: Core?, object: T) -> T {
    guard let wand else {
        return object
    }

    return wand + (object, T.self|)
}

@discardableResult
@inline(__always)
public
func &<T>(object: T, key: String?) -> (T, String) {
    (object, key ?? T.self|)
}

/// Sequence
@inline(__always)
public
func +<T>(wand: Core, raw: (sequence: T, Core.Key)) where T == any Sequence {
    raw.sequence.forEach {
        wand + $0
    }
}
