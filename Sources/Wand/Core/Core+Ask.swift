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

/// Store `Ask`
extension Core {

    @inlinable
    public
    func append<T>(ask: Ask<T>) -> Bool {

        let key = ask.key
        let stored = handlers[key]

        //Attach the wand
        //Call handler if object exist
        if
            ask.set(core: self),
            let object: T = get(for: key),
            !ask.handler(object)
        {
            return false
        }

        //Add ask to the chain
        let tail = stored?.last as? Ask<T>
        ask.next = tail?.next ?? ask
        tail?.next = ask

        handlers[key] = (last: ask, cleaner: stored?.cleaner)

        return stored == nil
    }

    @inline(__always)
    public
    func setCleaner<T>(for ask: Ask<T>, cleaner: @escaping ()->() ) {

        let key = ask.key
        handlers[key] = (handlers[key]!.last, cleaner)
    }

}

/// Add object
/// Call handlers
extension Core {

    @discardableResult
    @inlinable
    public
    func addIf<T>(exist object: T?, for key: String? = nil) -> T? {
        (object == nil) ? nil : add(object!, for: key) //https://forums.swift.org/t/ternary-unwrapping/84147 // ^ ?
    }

    @discardableResult
    @inlinable
    public
    func add<T>(_ object: T, for raw: String? = nil) -> T {

        //Store object and retreive the key
        let at = object ^ raw
        let key = self + at

        //Answer the questions
        guard let stored = handlers[key] else {
            return object
        }

        //From head
        if let tail = (stored.last as? Ask<T>)?.head(object) {
            //Save
            handlers[key] = (tail, stored.cleaner)
        } else {
            //Clean
            stored.cleaner?()
            handlers[key] = nil
        }

        //Handle .any
        if let tail = handlers[.any]?.last as? Ask<Any> {

            let head = tail.next
            handle(object, head: head, tail: tail)
            tail.next = head
        }

        return object
    }

    @inlinable
    public
    func add<T>(sequence: any Sequence<T>) {
        sequence.forEach {
            add($0)
        }
    }

}
