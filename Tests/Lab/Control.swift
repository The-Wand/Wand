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

import Wand
import AVFoundation

@available(iOS 18, macOS 12, tvOS 14, watchOS 7, *)
class CameraControl {
    
    private var controlsMap: [String: [AVCaptureControl]] = [:]
    private let sessionQueue = DispatchSerialQueue(label: "com.example.apple-samplecode.AVCam.sessionQueue")

    
    lazy
    var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        
        sessionQueue.async {
            session.startRunning()
        }
        return session
    }()
    
//    private var controlsDelegate = CaptureControlsDelegate()

    
    @available(iOS 18.0, *)
    func configureControls(for device: AVCaptureDevice! = try! DeviceLookup().defaultCamera) {
        
        guard captureSession.supportsControls else {
            return
        }
        
        captureSession.beginConfiguration()
        
        for control in captureSession.controls {
            captureSession.removeControl(control)
        }
        
        for control in createControls(for: device) {
            if captureSession.canAddControl(control) {
                captureSession.addControl(control)
            } else {
//                logger.info("Unable to add control \(control).")
            }
        }
        
        // Set the controls delegate.
//        captureSession.setControlsDelegate(controlsDelegate, queue: sessionQueue)
        
        
        captureSession.commitConfiguration()
    }
    
    @available(iOS 18.0, *)
    func createControls(for device: AVCaptureDevice) -> [AVCaptureControl] {
        
        if let controls = controlsMap[device.uniqueID] {
            return controls
        }
            
        let symbols: [String] = []
        
        let controls = symbols.map { name in
            AVCaptureSlider(name,
                            symbolName: name,
                            in: 0...1)
        }
        
        controlsMap[device.uniqueID] = controls
        return controls
        
    }
    
}


//struct Rar: AskNil, Wanded, ExpressibleByT {
//
//    @inline(__always)
//    public
//    static
//    func ask<C, T>(with scope: C, ask: Ask<T>) -> Core {
//
//        let wand = Core.to(scope)
//        _ = wand.append(ask: ask)
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak wand] in
//
//            //from scope
//            let archive = Rar()
//            wand?.add(archive, for: ask.key)
//        }
//
//        return wand
//    }
//
//    init() {
//    }
//
//}
//
//protocol ExpressibleByT: ExpressibleByNilLiteral, ExpressibleByStringLiteral {
//
//    init()
//
//}
//
//extension ExpressibleByT {
//
//    init(nilLiteral: ()) {
//        self.init()
//    }
//
//    init(stringLiteral value: String) {
//        let wand = Core.to(value)
//        wand | .one { (archive: Rar) in
//
//            //update self
//            print("#archived \(value)")
//        }
//
//        self.init()
//    }
//
//}


//func |?<T> (l: T?, r: (Any, Any)) {
//
//}
//func :| (l: Any, r: Any) -> (Any, Any) {
//
//}
//
///// Add object
///// Call handlers
//extension Core {
//
//    @discardableResult
//    @inlinable
//    public  //https://forums.swift.org/t/ternary-unwrapping/84147
//    func addIf<T>(exist object: T?, for key: String? = nil) -> T? {
//        (object == nil) ? nil : add(object!, for: key) //let object ? add(object, for: key) : nil
//    }
//
//@freestanding(expression)
//public
//macro loca(_ value: String...) -> (String) = #externalMacro(module: "WandMacros", type: "LocaMacro")
