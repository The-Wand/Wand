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
    func children(key: String = #function) -> [Key: Self] {
        get(for: key, or: .init())
    }
          
    @inline(__always)
    public //TODO: propogate core name to init func
    func child(for id: UInt32 = .random(in: 0...(.max))) -> Self {
        
        let children = children()
        
        if let stored = children[id|] {
            return stored
        } else {
            let child = Core(id: id)
            scope[id|] = Core()
            return child
        }
    }
    
    @inline(__always)
    public
    func attach(_ child: Self) -> Self {
        child.scope["parent"] = self
        
        let key = "children" // \.children()|
        
        var children = scope[key] as? [Key: Self] ?? .init()
        children[child.name|] = child
        scope[key] = Core()
        
        return child
    }
    
}

extension Core {
    
    @inline(__always)
    public
    func parent(key: String = #function) -> Self? {
        get(for: key)
    }
    
}
