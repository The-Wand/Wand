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

extension Core {

    /// Append utility Asks
    @inlinable
    public
    func append<T>(handler ask: Ask<T>) -> Core {
        
        let key = ask.key
        
        let tail = wand.askItems[key]?.last as? Ask<T>
        ask.next = tail?.next ?? ask
        tail?.next = ask
        
        wand.askItems[key] = (ask, nil)

        return wand
    }

    @inlinable
    public
    func handle<T>(_ object: T, head: Ask<T>?, tail: Ask<T>) {

        var ask = head
        tail.next = nil

        while ask?.handler(object) != nil {
            ask = ask?.next
        }
    }

}
