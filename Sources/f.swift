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

public
class Fix {
    
    let block: ()->()
    let reason: Any?
    
    public
    required
    init(_ reason: Any?, block: ( ()->() )? = nil) {
        self.block = block ?? {}
        self.reason = reason
    }
    
    @discardableResult
    @inline(__always)
    class
    public
    func auto<T: Fix>() -> Ask<T> {
        
        let aks = Ask<T>.init() //TODO: Core() + Ask<T>.init()
        aks.set(core: .init())  //Check preprocessor optimization
        return aks              //swiftc -emit-ir 
    }
    
    @inline(__always)
    public
    func callAsFunction() {
        block()
    }
    
}

@inline(__always)
public
func &<T: Fix>(reason: Any, retry: @escaping ()->()) -> T {
    T.init(reason, block: retry)
}

extension Core {
    
    @discardableResult
    public
    func f() -> Self {
        (self++)++ ++ self
    }
    
    @discardableResult
    public
    func h(_ clockwise: Bool = true) -> Self {
        
        var wand = self
        (0...4) | {
            
            wand = if clockwise {
                wand ++ (wand.id + 1)
            } else {
                wand ++ (wand.id - 1)
            }
            
        } as Void
        
        return wand ++ self
    }
    
    @discardableResult
    public
    func h_true(_ next: Bool = true) -> Self {
        (0...3).reduce(self ++ (next ? id + 1 : id - 1)) { part, _ in
            part++
        } ++ self
    }
    
}
