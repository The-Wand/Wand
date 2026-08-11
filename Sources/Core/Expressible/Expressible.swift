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
        
        let id: UInt32?
        
        if value.count == 1 {
            id = value.first!|
        } else {
            
            if #available(iOS 16.0, macOS 13.0, *) {
                
                //            3 | .every { (coffee: Coffee) in
                //
                //            }
                
                value | /(.*)(\|)(.*){(.|\n)*}/ | { i in
                    
                    
                    let input = i.1
                    let `operator` = i.2
                    
                    let label = i.3
                    
                    let scope = i.4
                    
                    print("Key: \(i.1)")
                    print("Value: \(i.2)")
                    
                    let wand = Core.to(input)
                    let ask: Ask<Any> = .init()//(results[i.3] + results[i.4])|
                    
                    print(wand)
                } as Void
                
            } else {
                
                let regex = "(.*)(\\|)(.*){(.|\n)*}"
                
//                value | regex {
                
            }
            
            id = nil //TODO: ?
        }
        
        self.init(id: id)
        scope[StringLiteralType.self|] = value
    }

}

//typealias RegexResult =

@available(iOS 16.0, macOS 13.0, *)
@inline(__always)
private
func |<T>(value: String, regex: Regex<T>) -> [Regex<T>.Match] {
    value.matches(of: regex)
}

@inline(__always)
private
func |(string: String, pattern: String) -> [NSTextCheckingResult] {
    try! NSRegularExpression(pattern: pattern, options: [])
        .matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
}
