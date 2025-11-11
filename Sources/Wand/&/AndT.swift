///
/// Copyright 2020 Alexander Kozin
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
/// Created by Alex Kozin
/// El Machine 🤖

import CoreGraphics
import UIKit

public
extension Ask {

    class Crop: Operation {
    }

    static
    func crop(to rect: CGRect) -> Crop {
        .init()
    }

    class Scale: Operation {

        var size: CGSize = .zero //TODO: change to let

    }

    static
    func scale(x value: Int, handler: @escaping (T)->() ) -> Scale {
        let scale = Scale.one(handler: handler)
//        scale.size = value|
        return scale
    }

    static
    func scale(to size: CGSize, handler: @escaping (T)->() ) -> Scale {
        let scale = Scale.one(handler: handler)
        scale.size = size
        return scale
    }

}

//let image: UIImage = .init()
//let rect: CGRect = .zero

//|image & .crop(to: rect) & .scale(x: 2) { (image: UIImage) in
//
//}
//
//@discardableResult
//func &<T> (input: T, ask: Ask<T>.Crop) -> T where T == UIImage {
//
//}
//
//@discardableResult
//func &<T> (input: T, ask: Ask<T>.Scale) -> T where T == UIImage {
//
//}

//func &<T: Asking> (input: T, ask: Ask<T>) -> T {
//
//}
//
//func &<T: Asking> (input: T, ask: Ask<T>) -> (T) -> () {
//
//}

func & (input: UIImage, ask: Ask<UIImage>.Scale) -> UIImage {
    let size = ask.size
    let scaled = UIGraphicsImageRenderer(size: size).image { c in
        input.draw(in: CGRect(origin: .zero, size: size))
    }

    return scaled
}


@inline(__always)
public
func & (ask: Ask<UIImage>, applying: Ask<UIImage>.Scale ) -> Ask<UIImage> {

    let saved = ask.handler
    ask.handler = {
        saved($0 & applying)
    }

    return ask
}


//@inline(__always)
//public
//func & (ask: Ask<UIImage>, applying: Ask<UIImage>.Crop ) -> Ask<UIImage> {
//
//    let saved = ask.handler
//    ask.handler = {
//        saved($0 & applying)
//    }
//
//    return ask
//}
//
//@inline(__always)
//public
//func &<T: Asking, O: Ask<T>.Operation> (ask: Ask<T>, applying: O ) -> Ask<T> {
//
//    let saved = ask.handler
//    ask.handler = {
//        saved($0 & applying)
//    }
//
//    return ask
//}

//@inline(__always)
//public
//func &<T: Asking> (ask: Ask<T>, applying: Ask<T>.Operation ) -> Ask<T> {
//
//    let saved = ask.handler
//    ask.handler = {
//        saved($0 & applying)
//    }
//
//    return ask
//}
//
//@inline(__always)
//func &<T: Asking> (input: T, ask: Ask<T>.Operation) -> T {
//    let output = input//|
//    return output
//}

