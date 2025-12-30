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

/// Ask object with default settings
public
extension Ask {

    typealias Nil = AskNil

}

/// TODO: func |(context: C, asks: Ask<Self>)
public
protocol AskNil: Ask.T {

}

/// Ask
///
/// |{ T in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func |<T: Ask.Nil>(handler: @escaping (T)->() ) -> Core {
    nil as Core | Ask.one(handler: handler)
}

/// Ask
/// - `every`
/// - `one`
/// - `while`
///
/// |.one { T in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func |<T: Ask.Nil>(ask: Ask<T>) -> Core {
    nil as Core | ask
}

/// Make the chain
///
/// T.one | E.one | { (error: Error?) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |<U: Ask.Nil, T: Ask.T>(l: Ask<U>, r: Ask<T>) -> Core {
    T.ask(with: U.ask(with: nil as Core, ask: l),
          ask: r)
}
