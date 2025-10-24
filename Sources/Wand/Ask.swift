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

/// The question with answer `handler`.
/// Will wait for new objects til handler returns `true`
open
class Ask<T> {

    /// Handler of T
    /// - Parameter object: Answer for the question
    /// - Returns: Need wait for next object?
    public
    var handler: (T)->(Bool)

    /// Next question
    public
    var next: Ask?
    
    /// Need only one
    public
    let once: Bool
    
    /// Question label
    internal
    var _key: String?

    ///@synthesize `key`
    @inline(__always)
    public
    var key: String {

        get {
            _key ?? T.self|
        }
        
        set {
            _key = newValue
        }

    }

    private
    var core: Core?

    ///@synthesize `wand`
    @discardableResult
    @inline(__always)
    public
    func set(core: Core?) -> Bool {
        self.core = core
        return false
    }

    @inline(__always)
    public
    convenience
    init(once: Bool = true, for key: String? = nil, handler: ( (T)->() )? = nil ) {
        self.init(once: once, for: key) {

            handler?($0)
            return !once
        }
    }

    @inline(__always)
    public
    required
    init(once: Bool, for key: String? = nil, handler: @escaping (T)->(Bool) ) {

        self._key = key
        self.once = once
        self.handler = handler
    }

    //TODO: Move to `Option`
    //`instance methods declared in extensions cannot be overridden`
    @inline(__always)
    public
    func optional() -> Option {
        Option(once: self.once, for: key, handler: handler)
    }

}

/// Request object
/// - `every`
/// - `one`
/// - `while`
extension Ask {

    /// Ask.every { T in
    ///
    /// }
    ///
    @inline(__always)
    public
    static
    func every(_ key: String? = nil, handler: ( (T)->() )? = nil ) -> Self {
        .init(once: false, for: key) {

            handler?($0)
            return true

        }
    }

    /// Ask.one { T in
    ///
    /// }
    ///
    @inline(__always)
    public
    static
    func one(_ key: String? = nil, handler: ( (T)->() )? = nil ) -> Self {
        .init(once: true, for: key) {

            handler?($0)
            return false

        }
    }

    /// Ask.while { T in
    ///     true
    /// }
    ///
    @inline(__always)
    public
    static
    func `while`(_ key: String? = nil, handler: @escaping (T)->(Bool) ) -> Self {
        .init(once: false, for: key, handler: handler)
    }

}

/// Handle answer
extension Ask {

    @discardableResult
    @inline(__always)
    public
    func head(_ object: T) -> Ask? {

        let head = next
        self.next = nil

        return head?.handle(object)

    }

    @inlinable
    internal
    func handle(_ object: T) -> Ask? {

        if handler(object) {

            //Store ask while true
            let tail = next?.handle(object) ?? self
            tail.next = self
            return tail

        } else {

            //Otherwise use next node
            return next?.handle(object)

        }

    }

}

extension Ask {

    @inline(__always)
    public
    func cancel() {
        
        set(core: nil)
        
        handler = { _ in
            false
        }
        
    }

}
