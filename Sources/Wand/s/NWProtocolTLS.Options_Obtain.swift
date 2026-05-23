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

extension NWProtocolTLS.Options: Obtainable {

    @inlinable
    public
    static
    func obtain<C>(with scope: C?, by wand: Core?) -> Self {

        let code: String = scope as? String ?? (wand?.get())!

        let tlsOptions = NWProtocolTLS.Options()

        let authenticationKey = SymmetricKey(data: (code | .utf8)!)
        let authenticationCode = HMAC<SHA256>.authenticationCode(for: "Wand".data(using: .utf8)!, using: authenticationKey)

        let authenticationDispatchData = authenticationCode.withUnsafeBytes {
            DispatchData(bytes: $0)
        }

        sec_protocol_options_add_pre_shared_key(tlsOptions.securityProtocolOptions,
                                                authenticationDispatchData as __DispatchData,
                                                "Wand"| as __DispatchData)
        sec_protocol_options_append_tls_ciphersuite(tlsOptions.securityProtocolOptions,
                                                    tls_ciphersuite_t(rawValue: TLS_PSK_WITH_AES_128_GCM_SHA256)!)

        return tlsOptions as! Self
    }

}

#endif
