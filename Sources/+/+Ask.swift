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

@inlinable
public
func +<T>(wand: Core, ask: Ask<T>) -> Bool {

    let key = ask.key
    let stored = wand.handlers[key]

    //Attach the wand
    //Call handler if object exist
    if
        ask.set(core: wand),
        let object: T = wand.get(for: key),
        !ask.handler(object)
    {
        return false
    }

    //Add ask to the chain
    let tail = stored?.last as? Ask<T>
    ask.next = tail?.next ?? ask
    tail?.next = ask

    wand.handlers[key] = (last: ask, cleaner: stored?.cleaner)

    return stored == nil
}


@inline(__always)
public
func &<T>(ask: Ask<T>, cleaner: @escaping ()->()) {
    
    let wand = ask.core!
    let key = ask.key
    wand.handlers[key] = (wand.handlers[key]!.last, cleaner)
}

extension Core {

    @available(*, deprecated, renamed: "&")
    @inline(__always)
    public
    func setCleaner<T>(for ask: Ask<T>, cleaner: @escaping ()->() ) {

        let key = ask.key
        handlers[key] = (handlers[key]!.last, cleaner)
    }

}
