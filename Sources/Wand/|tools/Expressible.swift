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

import Foundation

/// Init with Array
//extension Core: ExpressibleByArrayLiteral {
//
//    @inline(__always)
//    convenience
//    public
//    init(arrayLiteral array: Any...) {
//        
//        self.init()
//        put(sequence: array)
//
//    }
//
//    @inline(__always)
//    convenience
//    public
//    init(array: [Any]) {
//
//        self.init()
//        put(sequence: array)
//
//    }
//
//}

/// Init with Bool
extension Core: ExpressibleByBooleanLiteral {

    @inline(__always)
    convenience
    public
    init(booleanLiteral value: Bool) {

        self.init()
        context[BooleanLiteralType.self|] = value

    }

}

/// Init with Dictionary
extension Core: ExpressibleByDictionaryLiteral {

    @inline(__always)
    convenience
    public
    init(dictionaryLiteral elements: (String, Any)...) {

        self.init()

        elements.forEach { (key, object) in
            Core[object] = self
            context[key] = object
        }

    }

    @inline(__always)
    convenience
    public
    init(dictionary: [String: Any]) {

        self.init()

        dictionary.forEach { (key, object) in
            Core[object] = self
            context[key] = object
        }

    }

}

/// Init with extended grapheme cluster
extension Core: ExpressibleByExtendedGraphemeClusterLiteral {

    @inline(__always)
    convenience
    public
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {

        self.init()
        context[ExtendedGraphemeClusterLiteralType.self|] = value

    }

}

/// Init with Float
extension Core: ExpressibleByFloatLiteral {

    @inline(__always)
    convenience
    public
    init(floatLiteral value: Float) {

        self.init()
        context[FloatLiteralType.self|] = value

    }

}

/// Init with Int
extension Core: ExpressibleByIntegerLiteral {

    @inline(__always)
    convenience
    public
    init(integerLiteral value: Int) {

        self.init()
        context[IntegerLiteralType.self|] = value

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
        context[StringLiteralType.self|] = value

    }

}

//TODO: Fix and enable
/// Init with Unicode.Scalar
//extension Core: ExpressibleByUnicodeScalarLiteral {
//
//    @inline(__always)
//    convenience
//    public
//    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
//
//        self.init()
//        context[UnicodeScalarLiteralType.self|] = value
//
//    }
//
//}
