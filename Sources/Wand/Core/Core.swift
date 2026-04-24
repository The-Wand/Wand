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

@_exported
import Foundation

/// Wand.Core
/// Bus for <#Any#> Factory + Cache
@dynamicCallable
final
public
class Core: CustomStringConvertible, Identifiable {

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

    lazy
    public
    var id = arc4random()

    lazy
    public
    var name = id.quotientAndRemainder(dividingBy: 50_000)

    lazy
    public
    var description = "Wand.Core \(name.remainder| as Character)\n\(version) by @alko"

    @inlinable
    public
    var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    @inline(__always)
    public
    init() {
        log("|🦾 #init")
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
        request.addValue("Basic ZDgzYzA2YTg0NmJlNjdmYWY4ZDUzYTViZDI5Y2U2MzE6", forHTTPHeaderField: "Authorization")
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

/// Put objects
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
    func putDefault<T>(_ object: @autoclosure ()->(T), for raw: String? = nil) {

        let key = raw ?? T.self|
        if !(self ~= key) {
            save(object(), for: key)
        }
    }

    @discardableResult
    @inlinable
    public
    func save<T>(_ object: T, for raw: String? = nil) -> String {

        let key = raw ?? T.self|
        Core[object] = self
        scope[key] = object

        return key
    }

}

/// Put sequence
extension Core {

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

/// Close
public
extension Core {

    @inlinable
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

        scope.removeAll()
    }

}
