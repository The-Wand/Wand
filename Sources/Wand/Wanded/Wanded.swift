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

/// Object that supports Wand
public
protocol Wanded {

    var wand: Core {get}
    var isWanded: Core? {get}

}

extension Wanded {

    @inline(__always)
    public
    var wand: Core {
        isWanded ?? Core(self)
    }

    @inline(__always)
    public
    var isWanded: Core? {
        Core[self]
    }

}

/// Any?
/// All Optional object supports Wand
extension Optional {

    @inline(__always)
    public
    var wand: Core {
        isWanded ?? .to(self)
    }

    @inline(__always)
    public
    var isWanded: Core? {
        Core[self]
    }

}

/// Close Wand
@discardableResult
@inline(__always)
postfix
public
func |(wanded: Wanded?) -> Core? {
    
    let wand = wanded?.isWanded
    wand?.close()
    return wand

}
