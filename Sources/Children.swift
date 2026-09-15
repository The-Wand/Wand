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

//TODO: #54 Rewrite to return Proxy as Child
//Test
extension Core {
    
    public
    typealias `Self` = Core
    
    @inline(__always)
    public
    var children: [UInt32: any Wanded]? {
        `get`(for: (\Core.children)|)
    }

    @inlinable
    public
    subscript <T: Wanded>(child: UInt32) -> T? {
        
        get {
            children?[child] as? T
        }
        
        set {
            self ++ child
        }
    }
    
    @inline(__always)
    public
    var parent: Self? {
        `get`(for: (\Core.parent)|) ?? root
    }
    
    //TODO: add Shedinger's parent tests
    @inlinable
    public
    var root: Self {
        if let wand = Core.all[-1]?.item {
            return wand
        }
        
        let wand = Core()
        Core.all[-1] = Weak(item: wand)
        return wand
    }
    
}

@inline(__always)
public
func ++(wand: Core, id: UInt32? = nil) -> Core {
    
    let children = wand.children
    
    if let id, let stored = children?[id] {
        return stored as! Core
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
func ++<T: Wanded>(wand: Core, child: T) -> Core {
    
    let rhs = child.wand
    
    rhs.scope[(\Core.parent)|] = wand
    
    let key: String = (\Core.children)|
    
    var children = wand.children ?? .init()
    children[rhs.id] = child
    wand.scope[key] = children
    
    return rhs
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

//TODO: --
