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

class Vulture: Machine {
    
    let trees: [Tree] = [Tree(), Tree(), Yeast()]
    
    var formula: [Int] {
        [1]
    }
    
    let devices: [Machine] = [
        Compressor<Air>(),
        Compressor<Water>(),
        Generator<Electricity>(),
        
        Shield().on(),
        
        Lamp().on(),
        Proection().on()
    ]
    
    let resources: [Resource] = [
        Air(),
        Alcohol(),
        Bread(),
        Electricity(),
        Sugar(),
        Water(),
    ]
    
    let skills: [Skill] = [
        Driving()
    ]
        
}

protocol Resource {
    
}

protocol Generatable: Resource {
    
}

protocol Eat: Resource {
    
}

class Air: Machine, Expecting, Resource {
    
}


class Alcohol: Water {
    
}

class Electricity: Machine, Expecting, Generatable {
    
}

class Bread: Eat, Expecting {
    
}

class Sugar: Eat, Expecting {
    
}

protocol Liquid {
    
}

class Water: Machine, Expecting, Liquid, Resource {
    
}

class Compressor<T: Resource>: Machine {
    
}

class Generator<T: Generatable>: Machine {
    
}

protocol Enablable: Machine {
    
    func on() -> Self
    func off() -> Self
    
    func `switch`() -> Self
    
}

extension Enablable {
    
    func on() -> Self {
        self
    }
    
    func off() -> Self {
        self
    }
    
    func `switch`() -> Self {
        self
    }
    
}

class Lamp: Machine, Enablable {
    
}

class Proection: Machine, Enablable {
    
}

class Shield: Machine, Enablable {
    
}
