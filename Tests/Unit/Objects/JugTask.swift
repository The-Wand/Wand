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

import Any_
import Wand

public
class Machine: Proxy { //Krыan
    
    public
    required
    init() {
    }
    
}

class Countable: Machine, Expecting {
    
    var dimensions: [any Comparable]?
    var state: Int = 0 //enum
    
    convenience
    init(_ value: any BinaryInteger) {
        self.init()
        
        dimensions = [Measurement(value: Double(value),
                                  unit: UnitMass.grams),
        ]
    }
    
    public
    required
    init() {
        super.init()
    }
    
}

class Device: Countable {
    
}

class Plant: Countable {
    
}

class User: Machine {
    
    @inline(__always)
    public
    func rod()-> Rod {
        wand + Rod()
    }
    
}

///1
class Container: Device {

}
///2
class Grinder: Device { //TODO: 3_000_000 - 25
    
    @inline(__always)
    public
    func grind<T: Flower>(raw: T? = nil) -> T? {
        
        guard let flower = raw ?? isWanded?.get() else {
            return nil
        }
        
        var dimensions = flower.dimensions ?? []
        
        let dispersionIndex = dimensions.firstIndex {
            $0 is Measurement<UnitDispersion>
        }
        
        var dispersion: Measurement<UnitDispersion>
        if let dispersionIndex {
            dispersion = dimensions.remove(at: dispersionIndex) as! Measurement<UnitDispersion>
            dispersion.value = 25
        } else {
            dispersion = Measurement(value: 25,
                                     unit: UnitDispersion.partsPerMillion)
        }
        
        dimensions.append(dispersion)
        flower.dimensions = dimensions
        
        return flower
    }
    
}
    

///3
class Lift: Device {
    
    
    @inline(__always)
    public
    func smoke()-> Smoke? {
        
        if let flower: Flower = wand| {
            return wand + Smoke()//flower.amount)
        }
        
        return nil
    }
    
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
    func fire()-> Fire {
        wand + Fire()
    }
    
}
///7
class Fire: Machine {
    
    required
    init() {
        super.init()
        
        
        let 🔥: UInt32? = "🔥"|
        let wand = Core(id: 🔥)
        
        
//        self.wand = Core(id: 0x1F525)
//        self.wand = Core(name: 🔥)
        
        wand + Light() + Warm() + Rod()
    }
    
}
///8
class Rod: Machine {
    
}
///9
class Light: Machine {
    
}
///10
class Warm: Machine {
    
}

public
class Smoke: Machine, Expecting {
    
}
