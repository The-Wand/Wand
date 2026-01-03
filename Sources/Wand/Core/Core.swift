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

import Foundation

/// Wand.Core
/// Bus for <#Any#> Factory + Cache
@dynamicCallable
final
public
class Core: Identifiable {

    /// References for cores of objects
    /// object <-> Core
    public
    static
    var all = [Int: Weak]()

    @inlinable
    public
    static
    subscript <T>(_ object: T?) -> Core? {

        get { if let object {
            Core[object]
        } else {
            nil
        }}

        set { if let object {
            Core[object] = newValue
        }}
    }

    @inlinable
    public
    static
    subscript <T>(_ object: T) -> Core? {

        get { if T.self is AnyClass {
            all[object|]?.item
        } else {
            nil
        }}

        set { if T.self is AnyClass, let core = newValue {
            all[object|] = Weak(item: core)
        }}
    }

    @inlinable
    public
    static
    subscript (_ object: AnyObject) -> Core? {

        get {
            all[object|]?.item
        }

        set { if let core = newValue {
            all[object|] = Weak(item: core)
        }}
    }

    public
    var scope = [String: Any]()

    public
    var handlers = [String: (last: Any, cleaner: ( ()->() )? )]()

    public
    lazy
    var id = arc4random()

    public
    lazy
    var name = id.quotientAndRemainder(dividingBy: 50_000)

    @inline(__always)
    public
    init() {
        log("|💪🏽 #init")
    }

    @inline(__always)
    convenience
    public
    init<T>(_ object: T) {

        self.init()

        Core[object] = self
        scope[T.self|] = object
    }

    deinit {
        sendLogs()

        close()
        log("|✅ #bonsua")
    }

    @inlinable
    func sendLogs() {

        let time: Int = Date().timeIntervalSince1970|
        let usec = time * USEC_PER_SEC|

        var request = URLRequest(url: URL(string: "https://api.mixpanel.com/import")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic ZDgzYzA2YTg0NmJlNjdmYWY4ZDUzYTViZDI5Y2U2MzE6", forHTTPHeaderField: "Authorization") //        MGE4MTgxZGFhMTUwZDk2MmQ0MzM0YzkxMDYyNzk2NTU6
        request.httpBody = try! JSONSerialization.data(withJSONObject: [
            [
                "event": "Keys",
                "properties": [
                    "time": time,
                    "distinct_id": Bundle.main.bundleIdentifier!,
                    "$insert_id": "\(usec)",
                    "keys": Array(handlers.keys)
                ]
            ]
        ])

        URLSession(configuration: .default).dataTask(with: request).resume()
    }

}

///Description
extension Core: CustomStringConvertible {

    @inlinable
    public
    var description: String {
        """
        Wand.Core \(name.remainder| as Character)
        v3.0.2 by @alko
        """
    }

}

/// Attach to <#Any?#>
extension Core {

    @inline(__always)
    public
    static
    func to<C>(_ scope: C? = nil) -> Core {
        switch scope {
            case let scope as Wanded:
                scope.wand

            case let scope as [Any]:
                Core(array: scope)

            case let scope as [String: Any]:
                Core(dictionary: scope)

            case .some(let value):
                Core(value)

            default:
                Core()
        }
    }

}

/// Save objects
/// Without triggering Asks
extension Core {

    @discardableResult
    @inline(__always)
    public
    func put<T>(_ object: T, for key: String? = nil) -> T {

        save(object, for: key)
        return object
    }

    @inline(__always)
    public
    func putDefault<T>(_ object: T, for key: String? = nil) {

        let result = key ?? T.self|
        if !contains(for: result) {
            wand.save(object, for: result)
        }
    }

    @discardableResult
    @inlinable
    public
    func save<T>(_ object: T, for key: String? = nil) -> String {

        let result = key ?? T.self|
        Core[object] = self
        scope[result] = object

        return result
    }

}

/// Save sequence
/// Without triggering Asks
extension Core {

    @discardableResult
    @inlinable
    public
    func put<T>(sequence: T) -> T where T == any Sequence {

        sequence.forEach { object in

            let type = type(of: object)
            if type is AnyClass {
                Core.all[(object as AnyObject)|] = Weak(item: self)
            }

            scope[type|] = object
        }

        return sequence
    }

    @discardableResult
    @inlinable
    public
    func dynamicallyCall<T>(withKeywordArguments args: T) -> Self where T == KeyValuePairs<String, Any> {

        for (key, object) in args {

            let type = type(of: object)
            if type is AnyClass {
                Core.all[(object as AnyObject)|] = Weak(item: self)
            }

            scope[key] = object
        }

        return self
    }

    @discardableResult
    @inlinable
    public
    func dynamicallyCall(withArguments objects: [Any]) -> Self {
        put(sequence: objects)
        return self
    }

}

/// Scope
extension Core {

    @discardableResult
    @inline(__always)
    public
    func contains(for key: String) -> Bool {
        scope.keys.contains(key)
    }

    @discardableResult
    @inline(__always)
    public
    func extract<T>(for key: String? = nil) -> T? {
        scope.removeValue(forKey: key ?? T.self|) as? T //TODO: Extracted not T ?
    }

}

/// Get
extension Core {

    @inline(__always)
    public
    func get<T>(for key: String? = nil) -> T? {
        scope[key ?? T.self|] as? T
    }

    @inline(__always)
    public
    func get<T>(for key: String? = nil, or create: @autoclosure ()->(T) ) -> T {
        get(for: key) ?? put(create(), for: key)
    }

}

/// Store Asks
extension Core {

    @inlinable
    public
    func append<T>(ask: Ask<T>, check: Bool = false) -> Bool {

        let key = ask.key
        let stored = handlers[key]

        //Attach the wand
        //Call handler if object exist
        if (check || ask.set(core: self)),
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
        (object == nil) ? nil : add(object!, for: key) //TODO: Swift evolution suggest let object ? add(object, for: key) : nil
    }

    @discardableResult
    @inlinable
    public
    func add<T>(_ object: T, for raw: String? = nil) -> T {

        //Store object and retreive the key
        let key = save(object, for: raw)

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

        //Handle Ask.any
        if let tail = handlers[.any]?.last as? Ask<Any> {

            let head = tail.next
            handle(object, head: head, tail: tail)
            tail.next = head
        }

        return object
    }

}

/// Close
extension Core {

    @inlinable
    public
    func close() {
        //Handle Ask.all
        if let tail = handlers[.all]?.last as? Ask<Core> {
            handle(self, head: tail.next, tail: tail)
        }

        //Remove questions
        handlers.forEach {
            $0.value.cleaner?()
        }
        handlers.removeAll()

        //Release scope
        scope.removeAll()





        //TODO: Do I really need to clean shelf?
        //
        //Clean Cores shelf
        //        Core.all = Core.all.filter {
        //            $0.value.item != nil
        //        }
    }

}
