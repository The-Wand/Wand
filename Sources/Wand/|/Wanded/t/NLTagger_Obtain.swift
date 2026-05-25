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
///

/*
 Inspired by:
 2012 Rasmus Andersson <http://rsms.me/>
 */

#if canImport(Network)
@_exported
import NaturalLanguage

@_exported
import Wand

extension NLTagger: Obtainable {

    @inlinable
    public
    static
    func obtain<C>(with scope: C?, by wand: Core?) -> Self {

        let schemes = if let scope = scope as? [NLTagScheme] ?? wand?.get() {
            scope
        } else if let scope = scope as? NLTagScheme ?? wand?.get() {
            [scope]
        } else {
            [NLTagScheme]()
        }

        return NLTagger(tagSchemes: schemes) as! Self
    }

}

#endif
