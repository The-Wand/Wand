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

/// Ask object with default settings
///
/// TODO: func |(context: C, asks: Ask<Self>)
public
protocol AskingNil: Asking {

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
func |<T: Asking>(handler: @escaping (T)->() ) -> Core {
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
func |<T: Asking>(ask: Ask<T>) -> Core {
    nil as Core? | ask
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
func |<T: AskingNil, U: Asking>(l: Ask<T>, r: Ask<U>) -> Core {
    U.ask(with: T.ask(with: nil as Core?, ask: l),
          ask: r)
}
