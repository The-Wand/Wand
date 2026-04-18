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
import Network
@_exported
import Wand

extension NWBrowser: Obtainable {

    @inlinable
    public
    static
    func obtain(by wand: Core?) -> Self {

        let wand = wand ?? Core()

        let parameters: NWParameters = wand.get() ?? .init()
        parameters.includePeerToPeer = true

        let source = NWBrowser(for: .bonjour(type: "_wand._tcp", domain: nil),
                               using: parameters)

        return source as! Self
    }

}

extension NWBrowser.Result: Ask.Nil {

    @inlinable
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand.append(ask: ask) else {
            return true
        }

        let source: NWBrowser = wand.get()

        source |? .while { [weak wand] (state: NWBrowser.State) in

            switch state {
                case .ready:

                    wand?.add(sequence: source.browseResults)
                    return false

                default:
                    return true
            }
        }

        source.browseResultsChangedHandler = { [weak wand] newResults, change in
            wand?.add(sequence: newResults)
        }

        let queue: DispatchQueue = wand.get() ?? .global()
        source.start(queue: queue)

        return wand
    }

}

extension NWBrowser.State: Ask.Nil {

    @inlinable
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand.append(ask: ask) else {
            return true
        }

        let source: NWBrowser = wand.get()

        source.stateUpdateHandler = { [weak wand] in
            wand?.add($0)
        }

        let queue: DispatchQueue = wand.get() ?? .global()
        source.start(queue: queue)

        return wand
    }

}

#endif
