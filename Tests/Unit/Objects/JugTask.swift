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
/// Created by Alek Kozin
/// El Machine 🤖

import Any_
import Wand

protocol Machine: Proxy { //Krыan
    
}

class Countable: Expecting, Machine {
    
    var amount: [any Comparable]? = [Measurement(value: 1,
                                           unit: UnitMass.grams),
                                     Measurement(value: 25,
                                                 unit: UnitDispersion.partsPerMillion)
    ]
    var state: Int = 0 //enum
    
}

class Device: Countable {
    
}

class Plant: Countable {
    
}

protocol User: Machine {
    
}

///1
class Container: Device {

}
///2
class Grinder: Device {
    
    @inline(__always)
    public
    func grind() {
        
    }
    
}
///3
class Lift: Device {
    
}
///4
class Jug: Device {
    
}
///5
class Flower: Plant {
    
}
///6
class Lighter: Device {
    
    @inline(__always)
    public
    func fire() {
        
    }
    
}
///7
struct Fire: Machine {
    
    init() {
        self.wand = Core(id: 0x1F525)
//        self.wand = Core(name: "🔥")
    }
    
}
///8
struct Rod: Machine {
    
}
///9
struct Light: Machine {
    
}
///10
struct Warm: Machine {
    
}
