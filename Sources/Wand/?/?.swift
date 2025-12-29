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

/// Dependency operator
/// operator ?
prefix  operator |?
infix   operator |? : AdditionPrecedence

@discardableResult
@inline(__always)
prefix
public
func |?<T: Ask.Nil>(handler: @escaping (T)->() ) -> Core {
    nil as Core |? Ask.Option(handler: handler)
}

@discardableResult
@inline(__always)
prefix
public
func |?<T: Ask.Nil>(ask: Ask<T>) -> Core {
    nil as Core |? ask.optional()
}

@discardableResult
@inline(__always)
prefix
public
func |?<T: Ask.Nil>(ask: Ask<T>.Option) -> Core {
    nil as Core |? ask
}

@discardableResult
@inline(__always)
public
func |?<C, T: Askable>(context: C, handler: @escaping (T)->() ) -> Core {
    context |? Ask.Option(handler: handler)
}

@discardableResult
@inline(__always)
public
func |?<C, T: Askable>(context: C, ask: Ask<T>) -> Core {
    context |? ask.optional()
}

@discardableResult
@inline(__always)
public
func |?<C, T: Askable>(context: C, ask: Ask<T>.Option) -> Core {
    context | ask
}
