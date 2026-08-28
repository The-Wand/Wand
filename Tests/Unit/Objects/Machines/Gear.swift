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
/// Created by Aleksandr Kozin
/// The Wand

import Wand

//TODO: #54
public
class Gear: Machine, Expecting {
    
    let radius: Int
    let count: Int
    
    //TODO:
    //let system: NSUnit Inches
    //let type:
    
    public
    required
    init() {
        fatalError("init() has not been implemented")
    }
    
}

@discardableResult
@inline(__always)
public
func +<T>(gear: Gear?, object: T) -> T? where T == Double {
    
    guard let gear else {
        return nil
    }
    
    let wand = gear.wand
    
    wand.children | {
        if let child = $0.value as? Gear {
            
            //TODO: Check formula and test
            let moment: Double = object * gear.count| * gear.radius| / child.radius| * child.count|
            
            gear + moment
        }
    } as Void
    
    return gear.wand + object
}
