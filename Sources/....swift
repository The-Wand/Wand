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

@inline(__always)
postfix
public
func ...<T>(sequence: T) -> (sequence: T, Core.Key) {
    (sequence, .all)
}

//Every
@inline(__always)
postfix
public
func ...<T>(handler: @escaping (T)->()) -> Ask<T> {
    .init(once: false) {
        handler($0)
        return true
    }
}

//@inline(__always)
//postfix
//public
//func ...<T>(ask: Ask<T>) -> Ask<T> {
//    .init(once: false) {
//        handler($0)
//        return true
//    }
//}
//
//
//@inline(__always)
//public
//static
//var every: Ask<Self> {
//    .every()
//}

///While
@inline(__always)
postfix
public
func ...<T>(handler: @escaping (T)->(Bool)) -> Ask<T> {
    Ask.while(handler: handler)
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
//    @inline(__always)
//    public
//    static
//    func every(check: Bool = false,
//               _ key: String? = nil,
//               handler: ( (T)->() )? = nil ) -> Self
//    {
//        .init(once: false, check: check, for: key) {
//            
//            handler?($0)
//            return true
//        }
//    }
    
    /// Ask.one { T in
    ///
    /// }
    ///
    @inline(__always)
    public
    static
    func one(check: Bool = false,
             _ key: String? = nil,
             handler: ( (T)->() )? = nil ) -> Self
    {
        .init(once: true, check: check, for: key) {
            
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
    func `while`(check: Bool = false,
                 _ key: String? = nil,
                 handler: @escaping (T)->(Bool) ) -> Self
    {
        .init(once: false, for: key, handler: handler)
    }
    
}
