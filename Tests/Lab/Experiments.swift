//
//  Experiments.swift
//  WatchPlayTests
//
//  Created by Aleksander Kozin on 11/8/2569 BE.
//  Copyright © 2569 BE El Machine, Alex Kozin. All rights reserved.
//

import Foundation
import Testing
import Wand

@Test
func experiment() {
    Bot.auto()
    let f = Bot().wand.f()
    print(f)
    let h = Bot().wand.h()
    print(h)
    let ht = Bot().wand.h_true()
    print(ht)
    
    let wand: Core = "😀"
    let wand2: Core = "abc"
    
    //        (0x0000...0x0042) | {
    //            print(String($0| as Character) | .toUnicodeName)
    //        }
    
    //            let s = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non gravida felis. Vivamus interdum massa nulla, eu egestas ipsum eleifend non. Ut vel augue et orci fermentum consequat eget nec est. Aenean eleifend tempor nibh, a posuere lacus pharetra non. Praesent elementum ac urna convallis porttitor."
    ////
    //            s | { (tag: NLTag) in
    //                print(tag)
    //            }
    
    //            Log.level = .verbose
    //            Highload.highload_prod(of: 11)//)1_111_111)
    
    //            let archive: Rar = nil
    //            let archive2: Rar = "\u{00C237}"
    
    
//    CameraControl().configureControls()
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
