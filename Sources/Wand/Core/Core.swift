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

            let key = unsafeBitCast(object, to: Int.self)
            return all[key]?.item
        } else {
            return nil
        }}

        set { if T.self is AnyClass, let core = newValue {

            let key = unsafeBitCast(object, to: Int.self)
            all[key] = Weak(item: core)
        }}
    }

    /// Questions & Cleaners
    public
    var asking = [String: (last: Any, cleaner: ( ()->() )? )]()

    /// Execution context
    public
    var context = [String: Any]()

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
        context[T.self|] = object
    }

    deinit {

        sendAsking()
        close()

        log("|✅ #bonsua")
    }

    @inlinable
    func sendAsking() {

        let time: Int = Date().timeIntervalSince1970|
        let usec = time * USEC_PER_SEC|

        var request = URLRequest(url: URL(string: "https://api.mixpanel.com/import")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic ZDgzYzA2YTg0NmJlNjdmYWY4ZDUzYTViZDI5Y2U2MzE6", forHTTPHeaderField: "Authorization") //        MGE4MTgxZGFhMTUwZDk2MmQ0MzM0YzkxMDYyNzk2NTU6
        request.httpBody = try! JSONSerialization.data(withJSONObject: [
            [
                "event": "asking",
                "properties": [
                    "time": time,
                    "distinct_id": Bundle.main.bundleIdentifier!,
                    "$insert_id": "\(usec)",
                    "keys": Array(asking.keys)
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
        v3.0.1 by @alko
        """
    }

}

/// Attach to <#Any?#>
extension Core {

    @inline(__always)
    public
    static
    func to<C>(_ context: C? = nil) -> Core {
        switch context {
            case let context as Wanded:
                context.wand

            case let context as [Any]:
                Core(array: context)

                        case let context as [String: Any]: //TODO: Fix and enable
                            Core(dictionary: context)

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
        context[result] = object

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

                let address = Memory.address(for: object)
                Core.all[address] = Weak(item: self)
            }

            context[type|] = object
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

                let address = Memory.address(for: object)
                Core.all[address] = Weak(item: self)
            }

            context[key] = object
        }

        return self
    }

}

/// Check object availability
/// Context contains
extension Core {

    @discardableResult
    @inline(__always)
    public
    func contains(for key: String) -> Bool {
        context.keys.contains(key)
    }

}

/// Get
/// From context
extension Core {

    @inline(__always)
    public
    func get<T>(for key: String? = nil) -> T? {
        context[key ?? T.self|] as? T
    }

    @inline(__always)
    public
    func get<T>(for key: String? = nil, or create: @autoclosure ()->(T) ) -> T {
        get(for: key) ?? put(create(), for: key)
    }

}

/// Remove object
extension Core {

    @discardableResult
    @inline(__always)
    public
    func extract<T>(for key: String? = nil) -> T? {
        context.removeValue(forKey: key ?? T.self|) as? T
    }

}

/// Store Asks
extension Core {

    @inlinable
    public
    func append<T>(ask: Ask<T>, check: Bool = false) -> Bool {

        let key = ask.key
        let stored = asking[key]

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

        asking[key] = (last: ask, cleaner: stored?.cleaner)

        return stored == nil
    }

    @inline(__always)
    public
    func setCleaner<T>(for ask: Ask<T>, cleaner: @escaping ()->() ) {

        let key = ask.key
        asking[key] = (asking[key]!.last, cleaner)
    }

}

/// Add object
/// Call handlers
extension Core {

    @discardableResult
    @inlinable
    public
    func addIf<T>(exist object: T?, for key: String? = nil) -> T? {

        guard let object = object else {
            return nil
        }

        return add(object, for: key)
    }

    @discardableResult
    @inlinable
    public
    func add<T>(_ object: T, for raw: String? = nil) -> T {

        //Store object and retreive the key
        let key = save(object, for: raw)

        //Answer the questions
        guard let stored = asking[key] else {
            return object
        }

        //From head
        if let tail = (stored.last as? Ask<T>)?.head(object) {
            //Save
            asking[key] = (tail, stored.cleaner)
        } else {
            //Clean
            stored.cleaner?()
            asking[key] = nil
        }

        //Handle Ask.any
        if let tail = asking[.any]?.last as? Ask<Any> {

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
        if let tail = asking[.all]?.last as? Ask<Core> {
            handle(self, head: tail.next, tail: tail)
        }

        //Remove questions
        asking.forEach {
            $0.value.cleaner?()
        }
        asking.removeAll()

        //Release context
        context.removeAll()

        //TODO: Do I really need to clean shelf? //        //Clean Cores shelf //        Core.all = Core.all.filter { //            $0.value.item != nil //        }
    }

}
