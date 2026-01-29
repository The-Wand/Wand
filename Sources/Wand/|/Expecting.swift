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

/// Expect from scope
/// ``
public
protocol Expecting: Ask.Nil {

    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core
    
}

extension Expecting {

    @inline(__always)
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        _ = wand.append(ask: ask)
        return wand
    }

}
