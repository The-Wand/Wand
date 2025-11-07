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

/// Dependency operator
/// operator ?
prefix  operator |?
infix   operator |? : AdditionPrecedence

/// Ask ?
///
/// context |? { T in
///
/// }
///
@inlinable
public
func |?<C, T: Asking>(context: C, handler: @escaping (T)->() ) -> Core {
    context | Ask.Option(handler: handler)
}

@inline(__always)
@discardableResult
public
func |?<C, T: Asking>(context: C, ask: Ask<T>) -> Core {
    T.ask(with: context, ask: ask.optional())
}

/// Ask ?
///
/// |?{ T in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func |?<T: AskingNil>(handler: @escaping (T)->() ) -> Core {
    nil as Core? | Ask.Option(handler: handler)
}

/// Ask ?
///
/// |?{ T in
///
/// }
///
@discardableResult
@inline(__always)
prefix
public
func |?<T: AskingNil>(ask: Ask<T>) -> Core {
    nil as Core? | ask.optional()
}
