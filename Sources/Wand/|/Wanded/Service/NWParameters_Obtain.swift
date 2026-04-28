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
import CryptoKit
@_exported
import Network

@_exported
import Wand

extension NWParameters: Obtainable {

    @inlinable
    public
    static
    func obtain<C>(with scope: C?, by wand: Core?) -> Self {

        let wand = wand ?? Core.to(scope)

        if let code: String = wand.get() {
            let tcpOptions = NWProtocolTCP.Options()
            tcpOptions.enableKeepalive = true
            tcpOptions.keepaliveIdle = 2

            let options = init(tls: wand.get(), tcp: tcpOptions)
            options.includePeerToPeer = true

            let gameOptions = NWProtocolFramer.Options(definition: WandFramerProtocol.definition)
            self.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)

            return options
        }

        let parameters = NWParameters.applicationService

        let options = NWProtocolFramer.Options(definition: WandFramerProtocol.definition)
        parameters.defaultProtocolStack.applicationProtocols.insert(options, at: 0)

        return parameters
    }

}

#endif
