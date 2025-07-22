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

/// Ask from context
///
/// TODO: func |(wand: Core, ask: Ask<Self>)
public
protocol Asking {

    @inline(__always)
    static 
    func ask<C, T>(with context: C, ask: Ask<T>) -> Core

}

/// Ask
///
/// any | { T in
///
/// }
/// 
@inline(__always)
@discardableResult
public
func |<C, T: Asking>(context: C?, handler: @escaping (T)->() ) -> Core {
    context | Ask.every(handler: handler)
}

/// Ask
/// - `every`
/// - `one`
/// - `while`
///
/// any | .one { T in
///
/// }
///
@inline(__always)
@discardableResult
public
func |<C, T: Asking>(context: C?, ask: Ask<T>) -> Core {
    T.ask(with: context, ask: ask)
}

/// Ask without handler
///
/// Foo.one | Bar.every | { (error: Error) in
///
/// }
///
extension Asking {

    @inline(__always)
    public
    static
    var every: Ask<Self> {
        .every()
    }

    @inline(__always)
    public
    static
    var one: Ask<Self> {
        .one()
    }
    
}
    
/// Ask from Type
///
/// Foo.one {
///
/// }
///
extension Asking {
    
    @inline(__always)
    public
    static
    func every(handler: ( (Self)->() )? = nil) -> Ask<Self> {
        .every(handler: handler)
    }
    
    @inline(__always)
    public
    static
    func one(handler: ( (Self)->() )? = nil) -> Ask<Self> {
        .one(handler: handler)
    }
    
    @inline(__always)
    public
    static
    func `while`(handler: @escaping (Self)->(Bool) ) -> Ask<Self> {
        .while(handler: handler)
    }
    
}
