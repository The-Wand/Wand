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
typealias ApplicationDelegate = UIResponder & UIApplicationDelegate

public
typealias Application = UIApplication
public
typealias UserActivityRestoring = UIUserActivityRestoring

public
typealias Button = UIButton
public
typealias Label = UILabel

public
typealias View = UIView
public
typealias ViewController = UIViewController

public
typealias Window = UIWindow

#else
import AppKit

public
typealias ApplicationDelegate = NSObject & NSApplicationDelegate

public
typealias Application = NSApplication
public
typealias UserActivityRestoring = NSUserActivityRestoring

public
typealias Button = NSButton
public
typealias Label = NSTextField

public
typealias View = NSView
public
typealias ViewController = NSViewController

public
typealias Window = NSWindow
    
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
