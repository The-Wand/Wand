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

import Foundation

/// Wand.Core
/// Bus for <#Any#> Factory + Cache
public
final
class Core {

    public
    struct Weak {

        weak
        var item: Core?

        @inline(__always)
        public
        init(item: Core) {
            self.item = item
        }

    }

    public
    static
    var all = [Int: Weak]()

    @inline(__always)
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

    @inline(__always)
    public
    static
    subscript <T> (_ object: T) -> Core? {

        get { if T.self is AnyClass {
            let key = unsafeBitCast(object, to: Int.self)
            return all[key]?.item
        } else {
            return nil
        }}

        set { if T.self is AnyClass, let wand = newValue {
            let key = unsafeBitCast(object, to: Int.self)
            all[key] = Weak(item: wand)
        }}

    }

    public
    var asking = [String: (last: Any, cleaner: ( ()->() )? )]()

    public
    var context = [String: Any]()

    @inline(__always)
    public
    init() {
        log("|💪🏽 #init\n\(self)\n")
    }

    @inlinable
    convenience
    public
    init<T>(for object: T) {
        self.init()

        Core[object] = self
        context[T.self|] = object
    }

    deinit {
        sendAsking()
        close()
        log("|✅ #bonsua\n\(self)\n")
    }

    @inlinable
    func sendAsking() {

        let url = URL(string: "https://api.mixpanel.com/import?strict=1")!
        let time = Date().timeIntervalSince1970
        let id = Int(time * Double(USEC_PER_SEC))

        let body = [
            [
                "event": "asking",
                "properties": [
                    "time": time,
                    "distinct_id": Bundle.main.bundleIdentifier!,
                    "$insert_id": "\(id)",
                    "keys": Array(asking.keys)
                ]
            ]
        ]
        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic ZDgzYzA2YTg0NmJlNjdmYWY4ZDUzYTViZDI5Y2U2MzE6", forHTTPHeaderField: "Authorization")
        request.httpBody = bodyData

        let session = URLSession(configuration: .default)
        session.dataTask(with: request).resume()
    }

}

/// Attach to Any?
extension Core {

    @inlinable
    public
    static
    func to<C>(_ context: C? = nil) -> Core {
        switch context {
            case let context as Wanded:
                context.wand

            case let context as [Any]:
                Core(array: context)

            case let context as [String: Any]:
                Core(dictionary: context)

            case  nil:
                Core()

            default:
                Core(for: context)
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
        let key = store(object, key: raw)

        //Answer questions
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
        (asking["Any"]?.last as? Ask<Any>)?.head(object)

        return object
    }

    @discardableResult
    @inline(__always)
    public
    func addIf<T>(exist object: T?, for key: String? = nil) -> T? {
        
        guard let object = object else {
            return nil
        }

        return add(object, for: key)
    }

}

/// Ask
/// For objects
extension Core {

    @inlinable
    public
    func answer<T>(the ask: Ask<T>, check: Bool = false) -> Bool {

        let key = ask.key
        let stored = asking[key]

        //Call handler if object exist
        if check, let object: T = get(for: key), !ask.handler(object) {
            return stored != nil
        }

        //Attach wand
        ask.set(wand: self)

        //Add ask to chain
        let cleaner: ( ()->() )?
        if let stored {
            let last = (stored.last as! Ask<T>)

            ask.next = last.next
            last.next = ask

            cleaner = stored.cleaner
        } else {
            ask.next = ask
            cleaner = nil
        }

        asking.updateValue((last: ask, cleaner: cleaner), forKey: key)

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

/// Remove
/// Without triggering
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
        get(for: key) ?? put(create(), key: key)
    }

}

/// Save
/// Without triggering Asks
extension Core {

    @discardableResult
    @inline(__always)
    public
    func put<T: Sequence>(sequence: T) -> T {

        sequence.forEach { object in
            let key = type(of: object)|

            Core[object] = self
            context[key] = object
        }

        return sequence
    }

    @discardableResult
    @inline(__always)
    public
    func put<T>(_ object: T, key: String? = nil) -> T {
        store(object, key: key)
        return object
    }

    @inline(__always)
    public
    func putDefault<T>(_ object: T, key: String? = nil) {

        let result = key ?? T.self|
        if !contains(result) {
            wand.store(object, key: result)
        }
    }

    @discardableResult
    @inline(__always)
    public
    func store<T>(_ object: T, key: String? = nil) -> String {

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

    public
    func close() {

        //Handle Ask.all
        (asking["All"]?.last as? Ask<Core>)?.head(self)

        //Remove questions
        asking.forEach {
            $0.value.cleaner?()
            log("|🧼 \($0.value)")
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
