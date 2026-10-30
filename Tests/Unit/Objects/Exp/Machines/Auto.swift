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

public
class Car: Machine {
    
    let formula: [Int] = [2, 3]
    
}

public
class EB: Machine {
    
    let formula: [Int] = [1]
    
    let battery = Accumulator()
    
    let motors: [Motor] = [MotorWheel(), MotorWheel()]
    
    let remote: [Remote] = [Remote()]
    
    let accessories: [Accessory] = []// = [Light(), FacePanel(), Camera(), CupHolder(), LuggageStorage()]
    
    let skills: [Skill] = [
        .ollie,
        .Spin.360,
    ]
    
}


class Accumulator: Machine {
    
    func charge() {
        
    }
    
}

class Remote: Machine {
    
    func control() {
        
    }
    
    func pair() {
        
    }
    
    func forget() {
        
    }
    
}


class MotorWheel: Machine, Motor, Wheel {
    
}

protocol Accessory {
    
}

protocol Motor {
    
}

protocol Wheel {
    
}

extension Skill {
    
    class Spin: Skill {
        
        static
        var `180`: Self {
            Skill() as! Self
        }
        
        static
        var `360`: Self {
            Skill() as! Self
        }
        
        static
        var `720`: Self {
            Skill() as! Self
        }
        
    }
    
    static
    var ollie: Self {
        Skill() as! Self
    }
    
}
