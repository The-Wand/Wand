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

protocol Browsable: Ask.T {

}

extension Browsable {

    @inline(__always)
    static
    public
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand.append(ask: ask) else {
            return wand
        }

        return wand | ask.depend { (result: NWBrowser.Result) in

            guard
                case let .service(name: name,
                                  type: _,
                                  domain: _,
                                  interface: _) = result.endpoint,
                name == ask.key
            else {
                return
            }

            result.join()
        }
    }

}

extension NWBrowser.Result {

//    @inlinable
    fileprivate
    func join() {

        guard let wand = isWanded else {
            return
        }

        var connection: NWConnection? = wand.extract()
        if let connection {
            connection.cancel()
        }

        let pass: String = wand.get()!
        connection = NWConnection(to: endpoint,
                                  using: NWParameters(passcode: pass))

        wand.add(connection)
    }
}

#endif
