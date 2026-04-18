/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Set up parameters for secure peer-to-peer connections and listeners.
*/

import Network
import CryptoKit

extension NWParameters {

    public
	convenience
    init(passcode: String) {

		let tcpOptions = NWProtocolTCP.Options()
		tcpOptions.enableKeepalive = true
		tcpOptions.keepaliveIdle = 2


		self.init(tls: NWParameters.tlsOptions(passcode: passcode), tcp: tcpOptions)


		includePeerToPeer = true

        let gameOptions = NWProtocolFramer.Options(definition: WandFramerProtocol.definition)
		self.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)
	}


	private
    static
    func tlsOptions(passcode: String) -> NWProtocolTLS.Options {
		let tlsOptions = NWProtocolTLS.Options()

		let authenticationKey = SymmetricKey(data: passcode.data(using: .utf8)!)
		let authenticationCode = HMAC<SHA256>.authenticationCode(for: "Wand".data(using: .utf8)!, using: authenticationKey)

		let authenticationDispatchData = authenticationCode.withUnsafeBytes {
			DispatchData(bytes: $0)
		}

		sec_protocol_options_add_pre_shared_key(tlsOptions.securityProtocolOptions,
												authenticationDispatchData as __DispatchData,
												stringToDispatchData("Wand")! as __DispatchData)
		sec_protocol_options_append_tls_ciphersuite(tlsOptions.securityProtocolOptions,
													tls_ciphersuite_t(rawValue: TLS_PSK_WITH_AES_128_GCM_SHA256)!)
		return tlsOptions
	}

	// Create a utility function to encode strings as preshared key data.
	private static func stringToDispatchData(_ string: String) -> DispatchData? {
		guard let stringData = string.data(using: .utf8) else {
			return nil
		}
		let dispatchData = stringData.withUnsafeBytes {
			DispatchData(bytes: $0)
		}
		return dispatchData
	}
}
