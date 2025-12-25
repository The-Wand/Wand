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
/// Created by Aleksander Kozin
/// The Wand

/// Get <#Ubiquitous#> object
///
/// let object = U.self|
///
public
protocol Ubiquitous: Wanded {
    
    @inline(__always)
    static
    func access() -> Self
    
    @inline(__always)
    prefix
    static
    func | (the: Self) -> Self
    
}

/// Ubiquitous object
///
/// let object = T|
///
@inline(__always)
postfix
public
func |<T: Ubiquitous>(type: T.Type) -> T {
    T.access()
}

/// Ubiquitous object from wand
///
/// let object: T = wand|
///
@inline(__always)
postfix
public
func |<T: Ubiquitous>(wand: Core?) -> T {
    T.access()
}

/// Ubiquitous object from context
///
/// let object: T = context|
///
@inline(__always)
postfix
public
func |<C, T: Ubiquitous>(context: C) -> T {
    context as? T ?? T.access()
}

/// Ubiquitous unwrap
///
/// let option: T? = nil
/// let object = option|
///
@inline(__always)
postfix
public
func |<T: Ubiquitous>(object: T?) -> T {
    object ?? T.self|
}

///
/// Set <#Ubiquitous#>
///
/// |object
///
extension Ubiquitous {
    
    @inline(__always)
    @discardableResult
    prefix
    public
    static
    func | (the: Self) -> Self {
        the
    }
    
}

/// <#Ubiquitous#> from the Core
///
/// let object: T = wand.get()
///
extension Core {
    
    @inline(__always)
    public
    func get<T: Ubiquitous>(for key: String? = nil) -> T {
        T.access()
    }
    
}
