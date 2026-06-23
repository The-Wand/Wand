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


extension Core {
    
    public
    typealias `Self` = Core
    
    @inline(__always)
    public
    func children() -> [UInt32: Self]? {
        get(for: "children") //TODO: Remove C-P
    }
          
    @inline(__always)
    public
    func child(for id: UInt32? = nil) -> Self {
        
        let children = children()
        
        if let id, let stored = children?[id] {
            return stored
        } else {
            let child = if let id {
                Core(id: id)
            } else {
                Core()
            }
            
            child.scope["parent"] = self
            
            var mutable = children ?? [:]
            mutable[child.id] = child
            scope["children"] = mutable //TODO: Remove C-P
            
            return child
        }
    }
    
//    @discardableResult
//    @inline(__always)
//    public //TODO: Is it + syntax good here too?
//    func attach(_ child: Self) -> Self {
//        child.scope["parent"] = self
//        
//        let key = "children" //TODO: Remove C-P // \.children()|
//        
//        var children = scope[key] as? [UInt32: Self] ?? .init()
//        children[child.id] = child
//        scope[key] = children
//        
//        return child
//    }
    
}

@discardableResult
@inline(__always)
public
func +(wand: Core, child: Core) -> Core {
    child.scope["parent"] = wand
    
    let key = "children" //TODO: Remove C-P // \.children()|
    
    var children = wand.scope[key] as? [UInt32: Core] ?? .init()
    children[child.id] = child
    wand.scope[key] = children
    
    return child
}

extension Core {
    
    @inline(__always)
    public
    func parent() -> Self? {
        get(for: "parent")
    }
    
}
