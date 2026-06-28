///
/// Copyright 2569 Aleksander Kozin
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

infix   operator ++ : AdditionPrecedence

extension Core {
    
    public
    typealias `Self` = Core
    
    @inline(__always)
    public
    var children: [UInt32: Self]? {
        `get`(for: "children")
    }
    
    @inline(__always)
    public
    var parent: Self? {
        `get`(for: "parent")
    }
    
}

@inline(__always)
public
func ++(wand: Core, id: UInt32? = nil) -> Core {
    
    let children = wand.children
    
    if let id, let stored = children?[id] {
        return stored
    } else {
        let child = if let id {
            Core(id: id)
        } else {
            Core()
        }
        
        child.scope[(\Core.parent)|] = wand
        
        var mutable = children ?? [:]
        mutable[child.id] = child
        wand.scope[(\Core.children)|] = mutable
        
        return child
    }
}

@discardableResult
@inline(__always)
public
func ++(wand: Core, child: Core) -> Core {
    child.scope[(\Core.parent)|] = wand
    
    let key: String = (\Core.children)|
    
    var children = wand.scope[key] as? [UInt32: Core] ?? .init()
    children[child.id] = child
    wand.scope[key] = children
    
    return child
}

//TODO: Move to macros
extension KeyPath {
    
    postfix
    public
    static
    func |(path: KeyPath) -> String {
        "\(path)".components(separatedBy: ".").last ?? ""
    }
    
}

@inline(__always)
postfix
public
func ++(wand: Core) -> Core {
    
    let children = wand.children
    
    let child = Core()
    child.scope[(\Core.parent)|] = wand
    
    var mutable = children ?? [:]
    mutable[child.id] = child
    wand.scope[(\Core.children)|] = mutable
    
    return child
}
