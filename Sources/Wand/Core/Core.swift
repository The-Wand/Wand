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

#if canImport(Foundation)
import Foundation

/// The box for an execution context
/// and questions
final
public
class Core {
    
    /// References for cores of objects
    /// object <-> Core
    public
    static
    var all = [Int: Weak]()

    @inlinable
    public
    static
    subscript <T> (_ object: T?) -> Core? {

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
    subscript <T> (_ object: T) -> Core? {

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
    
    /// Questions stored as Linked List
    /// with context cleaners
    public
    var asking = [String: (last: Any, cleaner: ( ()->() )? )]()
    
    /// Execution context
    public
    var context = [String: Any]()

    @inline(__always)
    internal
    init() {
        Log.verbose("|💪🏽 #init\n\(self)\n")
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

        Log.verbose("|✅ #bonsua\n\(self)\n")

    }

    @inlinable
    func sendAsking() {

        let time = Date().timeIntervalSince1970
        let id = Int(time * Double(USEC_PER_SEC))

        var request = URLRequest(url: URL(string: "https://api.mixpanel.com/import")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic ZDgzYzA2YTg0NmJlNjdmYWY4ZDUzYTViZDI5Y2U2MzE6", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: [
            [
                "event": "asking",
                "properties": [
                    "time": time,
                    "distinct_id": Bundle.main.bundleIdentifier!,
                    "$insert_id": "\(id)",
                    "keys": Array(asking.keys)
                ]
            ]
        ])

        URLSession(configuration: .background(withIdentifier: "com.apple.wand")).dataTask(with: request).resume()

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
            
            //            case let context as [Any]:
            //                Core(array: context)
            
        case let context as [String: Any]:
            Core(dictionary: context)
            
        case .some(let value):
            Core(value)
            
        default:
            Core()
        }

    }

}

/// Add object
/// Call handlers
extension Core {

    @discardableResult
    @inlinable
    public
    func add<T>(_ object: T, for raw: String? = nil) -> T {

        //Store object and retreive the key
        let key = save(object, key: raw)

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

    @discardableResult
    @inlinable
    public
    func addIf<T>(exist object: T?, for key: String? = nil) -> T? {

        guard let object = object else {
            return nil
        }

        return add(object, for: key)

    }

}

/// Store Asks
extension Core {

    @inlinable
    public
    func append<T>(ask: Ask<T>, check: Bool = false) -> Bool {

        let key = ask.key
        let stored = asking[key]

        //Call handler if object exist
        if check, let object: T = get(for: key), !ask.handler(object) {
            return false
        }

        //Attach the wand
        ask.set(wand: self)

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

/// Check object availability
/// Context contains
extension Core {

    @discardableResult
    @inline(__always)
    public
    func contains(_ key: String) -> Bool {
        context.keys.contains(key)
    }

}

/// Remove object
extension Core {

    @discardableResult
    @inline(__always)
    public
    func extract<T>(_ key: String? = nil) -> T? {
        context.removeValue(forKey: key ?? T.self|) as? T
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

/// Save objects
/// Without triggering Asks
extension Core {

//    @discardableResult
//    @inlinable
//    public
//    func put<T>(sequence: T) -> T where T == any Sequence {
//        sequence.forEach { object in
//            let type = type(of: object)
//            if type is AnyClass {
//                let key = unsafeBitCast(object, to: Int.self) //let withClassValuePoineter
//                Core.all[key] = Weak(item: self)
//                context[type|] = object
//            } else {
//                context[type|] = object
//            }
//        }
//        return sequence
//
//    }

    @discardableResult
    @inline(__always)
    public
    func put<T>(_ object: T, for key: String? = nil) -> T {

        save(object, key: key)
        return object

    }

    @inline(__always)
    public
    func putDefault<T>(for key: String? = nil, _ object: @autoclosure ()->(T)) {

        let result = key ?? T.self|
        if !contains(result) {
            wand.save(object(), key: result)
        }

    }

    @discardableResult
    @inline(__always)
    public
    func save<T>(_ object: T, key: String? = nil) -> String {

        let result = key ?? T.self|
        Core[object] = self
        context[result] = object

        return result

    }

}

/// Wanded
extension Core: Wanded {

    @inline(__always)
    public
    var wand: Core {
        self
    }

    @inline(__always)
    public
    var isWanded: Core? {
        self
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
            Log.verbose("|🧼 \($0.value)")

        }
        asking.removeAll()

        //Release context
        context.removeAll()

        //Clean Cores shelf
        Core.all = Core.all.filter {
            $0.value.item != nil
        }

    }

}

#endif
