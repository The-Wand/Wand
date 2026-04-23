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

@available(iOS 16.0, *)
extension NWConnection: Ask.Nil, Wanded {

//    @inlinable
    public
    static
    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {

        let wand = Core.to(scope)
        guard wand.append(ask: ask) else {
            return true
        }

        let parameters: NWParameters = wand.get()!
//        if #available(macOS 13.0, iOS 16.0, watchOS 9.0, *) {
//            wand.get() ?? NWParameters.applicationService
//        } else {
//            NWParameters()
//        }
//
//        let gameOptions = NWProtocolFramer.Options(definition: WandFramerProtocol.definition)
//        parameters.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)

        do {
            let source = try NWListener(using: parameters)
            source.service = .Service(name: ask.key, type: "_wand._tcp")

            source.newConnectionHandler = { [weak wand] in
                wand?.add($0)
                $0.startConnection()
            }

            source.start(queue: .main)
        } catch {
            wand.add(error)
        }

        return wand
    }

//    @inlinable
    private
    func startConnection() {

        guard let wand = isWanded else {
            return
        }

        let delegate = wand + Delegate()

        stateUpdateHandler = { [weak self] in

            guard let self else {
                return
            }

            switch $0 {
                case .ready:

                    receiveMessages()

                    // Notify the delegate that the connection is ready.
                    delegate.connectionReady()

                case .failed(let error):

                    cancel()

                    if
                        wand.get(for: "initiatedConnection") == true,
                        error == NWError.posix(.ECONNABORTED) {
                        // Reconnect if the user suspends the app on the nearby device.
                        let connection = NWConnection(to: endpoint, using: applicationServiceParameters())
                        wand.add(connection)
                    } else {
                        delegate.connectionFailed()
                    }
                default:
                    break
            }
        }

        let q: DispatchQueue = wand.get() ?? .main
        start(queue: q)
    }

    private
    func applicationServiceParameters() -> NWParameters {
        let parameters = NWParameters.applicationService

        // Add your custom game protocol to support game messages.
        let gameOptions = NWProtocolFramer.Options(definition: WandFramerProtocol.definition)
        parameters.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)

        return parameters
    }

    private
    func receiveMessages() {

        guard let wand = isWanded else {
            return
        }

        let delegate: Delegate = wand.get()!

        receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            if let gameMessage = context?.protocolMetadata(definition: WandFramerProtocol.definition) as? NWProtocolFramer.Message {
                delegate.receivedMessage(content: content, message: gameMessage)
            }
            if error == nil {
                // Continue to receive more messages until you receive an error.
                self.receiveMessages()
            }
        }
    }
}

private
struct Delegate {

    func connectionReady() {

    }

    func connectionFailed() {

    }

    func receivedMessage(content: Data?, message: NWProtocolFramer.Message) {

    }

    func displayAdvertiseError(_ error: NWError) {

    }
}

#endif
