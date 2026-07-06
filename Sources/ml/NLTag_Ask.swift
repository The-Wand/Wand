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

#if canImport(Network)
@_exported
import NaturalLanguage

@available(iOS 16.0, *)
extension NLTag: Ask.Nil, Wanded {

    @inlinable
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand + ask else {
            return true
        }

        let string  = scope as? String ?? wand.get()!

        let source = scope as? NLTagger ?? wand.get()
        source.string = string

        var stop = false
        wand.setCleaner(for: ask) {
            stop = true
        }

        let range = scope as? Range<String.Index> ?? wand.get() ?? string.startIndex..<string.endIndex
        let schema  = scope as? NLTagScheme ?? wand.get() ?? .lemma
        let unit    = scope as? NLTokenUnit ?? wand.get() ?? .word

        source.enumerateTags(in: range, unit: unit, scheme: schema) { tag, tokenRange in

            wand.put(tokenRange)
            wand + tag

            return stop
        }

        return wand
    }

}

#endif
