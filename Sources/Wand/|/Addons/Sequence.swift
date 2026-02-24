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

///forEach
@inline(__always)
public
func |<C: Sequence> (p: C?, handler: @escaping (C.Element) -> Void) {
    p?.forEach(handler)
}

@inline(__always)
public
func |<C: Sequence> (p: C?, handler: @escaping () -> Void) {
    p?.forEach { _ in
        handler()
    }
}

///filter
@inline(__always)
public
func |<C: Sequence> (p: C, handler: @escaping (C.Element) -> Bool) -> [C.Element] {
    p.filter(handler)
}

///first
@inline(__always)
public
func |<C: Sequence> (p: C?, handler: @escaping (C.Element) -> Bool) -> C.Element? {
    p?.first(where: handler)
}

///map
@inline(__always)
public
func |<C: Sequence, T> (p: C, handler: @escaping (C.Element) -> T) -> [T] {
    p.map(handler)
}

///reduce
@inline(__always)
public
func |<C: Sequence, T> (p: C,
                        to: (initial: T, next: (T, C.Element) -> T)) -> T {
    p.reduce(to.initial, to.next)
}
