//  Copyright © 2569 Aleksandr Kozin
//
//  Pomodoro
//  Private
//
//  Created by Aleksandr Kozin
//  2569
//

public
struct Platform {
    
}

#if canImport(UIKit)
import UIKit

public
extension Core {
    
    typealias ApplicationDelegate = UIResponder & UIApplicationDelegate
    
    typealias Application = UIApplication
    typealias Button = UIButton
    typealias Label = UILabel
        
    typealias View = UIView
    typealias ViewController = UIViewController
    
    typealias Window = UIWindow
    
}

#else
import AppKit

public
extension Core {
    
    public
    typealias ApplicationDelegate = NSObject & NSApplicationDelegate
    
    typealias Application = NSApplication
    typealias Button = NSButton
    typealias Label = NSTextField
    
    typealias View = NSView
    typealias ViewController = NSViewController
    
    typealias Window = NSWindow
    
}

public
extension NSTextField {
    
    var text: String {
        get {
            stringValue
        }
        set {
            stringValue = newValue
        }
    }
    
}

#endif

public
typealias LayoutConstraint = NSLayoutConstraint
