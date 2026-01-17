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

import Foundation

/// Init with Bool
extension Core: ExpressibleByBooleanLiteral {

    @inline(__always)
    convenience
    public
    init(booleanLiteral value: Bool) {

        self.init()
        scope[BooleanLiteralType.self|] = value
    }

}

/// Init with Float
extension Core: ExpressibleByFloatLiteral {

    @inline(__always)
    convenience
    public
    init(floatLiteral value: Float) {

        self.init()
        scope[FloatLiteralType.self|] = value
    }

}

/// Init with Int
extension Core: ExpressibleByIntegerLiteral {

    @inline(__always)
    convenience
    public
    init(integerLiteral value: Int) {

        self.init()
        scope[IntegerLiteralType.self|] = value
    }

}

/// Init from nothing
extension Core: ExpressibleByNilLiteral {

    @inline(__always)
    convenience
    public
    init(nilLiteral: ()) {
        self.init()
    }

}

/// Init with String
extension Core: ExpressibleByStringLiteral {

    @inline(__always)
    convenience
    public
    init(stringLiteral value: String) {

        self.init()
        scope[StringLiteralType.self|] = value
    }

}
