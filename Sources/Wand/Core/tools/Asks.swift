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

@inlinable
public
func +<T>(wand: Core, ask: Ask<T>) -> Bool {

    let key = ask.key
    let stored = wand.handlers[key]

    //Attach the wand
    //Call handler if object exist
    if
        ask.set(core: wand),
        let object: T = wand.get(for: key),
        !ask.handler(object)
    {
        return false
    }

    //Add ask to the chain
    let tail = stored?.last as? Ask<T>
    ask.next = tail?.next ?? ask
    tail?.next = ask

    wand.handlers[key] = (last: ask, cleaner: stored?.cleaner)

    return stored == nil
}

extension Core {

    @inline(__always)
    public
    func setCleaner<T>(for ask: Ask<T>, cleaner: @escaping ()->() ) {

        let key = ask.key
        handlers[key] = (handlers[key]!.last, cleaner)
    }

}

/// Objects
@discardableResult
@inlinable
public
func +<T>(wand: Core, raw: (T, String) ) -> T {

    let object = raw.0
    let key = wand.save(object, for: raw.1)

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

    //Handle Ask.any
    if let tail = wand.handlers[.any]?.last as? Ask<Any> {

        let head = tail.next
        wand.handle(object, head: head, tail: tail)
        tail.next = head
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

infix   operator +? : AdditionPrecedence

@discardableResult
@inline(__always)
public
func +?<T>(wand: Core, object: T? ) -> T? {

    guard let object else {
        return nil
    }

    return wand + object & nil
}

@discardableResult
@inline(__always)
public
func +?<T>(wand: Core, pair: (T?, String?) ) -> T? {
    pair.0 == nil ? nil : wand + pair.0! & pair.1
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

@inline(__always)
postfix
public
func ...<T>(sequence: T) -> (sequence: T, Core.Key) {
    (sequence, .all)
}
