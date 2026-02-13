////
////  NW.swift
////  Wand
////
////  Created by Aleksander Kozin on 31/12/25.
////  Copyright © 2025 El Machine, Alex Kozin. All rights reserved.
////
//
//import Network
//
//extension NWBrowser: Obtainable {
//
//    @inlinable
//    public
//    static
//    func obtain(by wand: Core?) -> Self {
//
//        let wand = wand ?? Core()
//
//        let parameters: NWParameters = wand.get() ?? .init()
//        parameters.includePeerToPeer = true
//
//        let source = NWBrowser(for: .bonjour(type: "_wand._tcp", domain: nil),
//                               using: parameters)
//
//        return source as! Self
//    }
//
//
//}
//
//struct B {
//
//    func start() {
//    }
//
//}
//
//extension NWBrowser.Result: Ask.Nil {
//
//    @inlinable
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//        guard wand.append(ask: ask) else {
//            return true
//        }
//
//        let source: NWBrowser = wand.get()
//
//        source |? .while { [weak wand] (state: NWBrowser.State) in
//
//            switch state {
//                case .ready:
//
//                    wand?.add(sequence: source.browseResults)
//                    return false
//
//                default:
//                    return true
//            }
//        }
//
//        source.browseResultsChangedHandler = { [weak wand] newResults, change in
//            wand?.add(sequence: newResults)
//        }
//
//        let queue: DispatchQueue = wand.get() ?? .global()
//        source.start(queue: queue)
//
//        return wand
//    }
//
//}
//
//extension NWBrowser.State: Ask.Nil {
//
//    @inlinable
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//        guard wand.append(ask: ask) else {
//            return true
//        }
//
//        let source: NWBrowser = wand.get()
//
//        source.stateUpdateHandler = { [weak wand] in
//            wand?.add($0)
//        }
//
//        let queue: DispatchQueue = wand.get() ?? .global()
//        source.start(queue: queue)
//
//        return wand
//    }
//
//}
//
//
//
//extension NWConnection: Ask.Nil {
//
//    @inlinable
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//        guard wand.append(ask: ask) else {
//            return true
//        }
//
//        let parameters: NWParameters =
//        if #available(macOS 13.0, iOS 16.0, watchOS 9.0, *) {
//            wand.get() ?? NWParameters.applicationService
//        } else {
//            NWParameters()
//        }
//
//        let gameOptions = NWProtocolFramer.Options(definition: GameProtocol.definition)
//        parameters.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)
//
//        do {
//            let source = try NWListener(using: parameters)
//            source.service = NWListener.Service(name: ask.key,
//                                                type: "_wand._tcp")
//
//            source.newConnectionHandler = { [weak wand] in
//                wand?.add($0)
//
////                if let delegate = self.delegate {
////                    if sharedConnection == nil {
////                        // Accept a new connection.
////                        sharedConnection = PeerConnection(connection: newConnection, delegate: delegate)
////                    } else {
////                        // If a game is already in progress, reject it.
////                        newConnection.cancel()
////                    }
////                }
//
//            }
//
//            source.start(queue: .main)
//        } catch {
//            wand.add(error)
//        }
//
//        return wand
//    }
//
//}
