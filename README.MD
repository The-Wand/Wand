
## **[Declarative Programming Language](https://github.com/The-Wand/Wand)**

|wand created to support all platfroms   
Prototype implemented on Swift

```bash looks great in the Markdown file
Location.one | MotionEvent.one | .all {

}
```

### [Package Collection ℹ️](https://swiftpackageindex.com/package-collections)
[📦 |Packages](https://raw.githubusercontent.com/The-Wand/Wand/main/collection.json)   

### Packages
[🏛️ |Foundation](https://github.com/The-Wand/Foundation)   
[🔖 |Location](https://github.com/The-Wand/Location)   
[🏃 |Motion](https://github.com/The-Wand/Motion)   
[📡 |NFC](https://github.com/The-Wand/NFC)   
[🖥️ |URL](https://github.com/The-Wand/URL)   
[🌤️ |Weather](https://github.com/The-Wand/Weather)   

Add one sign and wait for the result |   
ex [Pipe](https://github.com/The-Wand/Pipe)   
ex [API](https://github.com/The-Wand/iOS-API-Wrapper)       

### ⚙️ Usage

```swift
//Request location updates
|{ (location: CLLocation) in 

}
```
```swift
//Request .authorizedAlways permissions and only one location object
CLAuthorizationStatus.authorizedAlways | { (status: CLAuthorizationStatus) in
            
} | .one { (location: CLLocation) in 

}
```

**📦 An ideal API acts as the [black box](https://wikipedia.org/wiki/Blackbox)**  
**⚡️ It’s possible to incapsulate whole data receiving process and memory managment duty to one symbol?**   

[Medium.com](https://medium.com/@al.kozin/universal-api-7ddc67bb0aa5)
[YouTube.com](https://www.youtube.com/playlist?list=PLvprpeoOl6IoZ67BcD-t0rS1L5c5J4lPh)
[Habr.com](https://habr.com/ru/post/674010/)
  
>In Unix-like computer operating systems, a [pipeline](https://wikipedia.org/wiki/Pipeline_(Unix)) is a mechanism for inter-process communication using message passing. A pipeline is a set of processes chained together by their standard streams, so that the output text of each process (stdout) is passed directly as input (stdin) to the next one. The second process is started as the first process is still executing, and they are executed concurrently.

```bash
command1 | command2 | command3

ls -l | grep key | less
```

### 🕹️ How to
[![How to add REST API support to Swift project](https://img.youtube.com/vi/I81GEbc1ES8/0.jpg)](https://www.youtube.com/watch?v=I81GEbc1ES8)

```swift
//Request .authorizedWhenInUse permissions
CLAuthorizationStatus.authorizedWhenInUse | { (status: CLAuthorizationStatus) in
 
}
```
```swift
//Request location updates
//Uses .startUpdatingLocation()
|{ (location: CLLocation) in 

}
```
```swift
//Request .authorizedAlways permissions and only one location object
//Uses .requestLocation() for efficient power consumption
CLAuthorizationStatus.authorizedAlways | { (status: CLAuthorizationStatus) in
            
} | .one { (location: CLLocation) in 

}
```
```swift
//Request pedometer data updates
|{ (data: CMPedometerData) in 

}
```
```swift
//Scan for a bluetooth peripherals
|{ (peripheral: CBPeripheral) in 

}
```
```swift
//Wait for a Notification
UIWindow.keyboardWillShowNotification | { (n: Notification) in
            
}
```
```swift
//Enumerate contacts
CNContact.predicateForContacts(matchingName: "John") | .every { (contact: CNContact) in
                        
}
```
```swift
//Scan a tag
|.every { (tag: NFCNDEFTag) in

}
```
```swift
//Perform face observation
URL(string: "http://example.com/image.jpg") | { (faces: [VNFaceObservation]) in

}
```
```swift
//Perform pose observation
//Wait for two persons
data | .while { (bodies: [VNHumanBodyPoseObservation]) in
    bodies < 2
}
```
```swift
//Detect shakes
|{ (motion: UIEvent.EventSubtype) in
    if motion == .motionShake {
                
    }
}

```

```swift
//Customization
let wand = |{ (hands: [VNHumanHandPoseObservation]) in

}

let request: VNDetectHumanHandPoseRequest = wand.obtain()
request.maximumHandCount = 4

let preview: AVCaptureVideoPreviewLayer = wand.obtain()
view.layer.addSublayer(preview!)
```

### ❗ Error handling

```swift
//Attach Ask<Error> to the context
any | { (error: Error) in
    
}
```
```swift
//Or use the result handler
//Nil error means successed result
any | { (error: Error?) in
    
}
```

### 💡 Idea
  Imagine that you have the black box that can give you an ```Any``` object.   
  You don't know what's already in the box and [what happens inside.](https://wikipedia.org/wiki/Encapsulation_(computer_programming))   
      
  Ask for object that you need with |

```bash
|{ (result: Object) in
            
}
```
```bash
ingredients | { (result: Object) in
            
}
```
```bash
ingredients | .one { (t: T) in
            
} | .every { (u: U) in

} | .while { (v: V) in
  true
}
```

### 🪄 Сoncept

Wand started from the idea about receiving anything in most efficient way.   
Add one sign to anything and retreive the result 📦

You ideas, comments and contributions are welcome |

### 📚 Books

🖼️ Design Patterns: Elements of Reusable Object-Oriented Software (1994)   
$\hspace{17pt}$ GOF: Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides

🧼 Clean Code: A Handbook of Agile Software Craftsmanship (2008)   
$\hspace{17pt}$ Robert C. Martin  

🎼 Introduction to TRIZ. Basic Concepts and Approaches (2015)   
$\hspace{17pt}$ G.S. Altshuller  

🏛️ Clean Architecture: A Craftsman's Guide to Software Structure and Design (2017)   
$\hspace{17pt}$ Robert C. Martin  

😜 The Inmates Are Running the Asylum:   
$\hspace{17pt}$ Why High Tech Products Drive Us Crazy and How to Restore the Sanity (2019)   
$\hspace{17pt}$ Alan Cooper 

⊶ $\hspace{5pt}$ Origin (2017)   
$\hspace{17pt}$ Dan Brown 

⏳ The Deadline: A Novel About Project Management (2007)   
$\hspace{17pt}$ Tom DeMarco

## [🤝 Inspirtation](https://github.com/El-Machine/Wand/blob/main/INSPIRATION.TXT)

💿 CD Production   
$\hspace{17pt}$ Sony Digital Audio Disk Corporation   
$\hspace{17pt}$ ソニー・グループ株式会社   
$\hspace{17pt}$ https://sony.com

🪟 Windows   
$\hspace{17pt}$ Stan Barnes, William and Lynne Jolitz   
$\hspace{17pt}$ https://support.microsoft.com/windows

📱 iPod   
$\hspace{17pt}$ Tony Fadell   
$\hspace{17pt}$ [ˈaɪˌpɔd]   
$\hspace{17pt}$ https://wikipedia.org/wiki/Tony_Fadell

🍏  Apple   
$\hspace{17pt}$ Steve Jobs, Steve Wozniak   
$\hspace{17pt}$ A prominent part of macOS's original brand identity was   
$\hspace{17pt}$ the use of Roman numeral X, pronounced "ten"   
$\hspace{17pt}$ https://wikipedia.org/wiki/Steve_Jobs

⚙️ BSD   
$\hspace{17pt}$ Berkeley, 1974   
$\hspace{17pt}$ https://wikipedia.org/wiki/BSD

🔔 The concept of pipelines was championed by Douglas McIlroy   
$\hspace{17pt}$ Bell Labs   
$\hspace{17pt}$ https://wikipedia.org/wiki/Pipeline_(Unix)

$\hspace{4pt}$ | $\hspace{3pt}$ Wand icon   
$\hspace{17pt}$ Freepik - Flaticon   
$\hspace{17pt}$ https://flaticon.com/free-icons/wand

🤖 Enchanced by AI in 2025   
$\hspace{17pt}$ Augmented Intelligence / Artificial Intelligence   
$\hspace{17pt}$ Thanks for our conversations    
$\hspace{17pt}$ https://www.google.com?q=ai
    
⚡️ Macromedia® Flash   
$\hspace{17pt}$ 600 Townsend Street, San Francisco, CA 94103 1997   
$\hspace{17pt}$ Now vector-based interactive web animations, buttons, and graphics   
$\hspace{17pt}$ can be used on every Web page   
$\hspace{17pt}$ https://wikipedia.org/wiki/Macromedia

🐢 Logo   
$\hspace{17pt}$ Bolt, Beranek and Newman 1967   
$\hspace{17pt}$ The language was conceived to teach concepts of programming related to Lisp   
$\hspace{17pt}$ and only later to enable what Papert called "body-syntonic reasoning", where   
$\hspace{17pt}$ students could understand, predict, and reason about the turtle's motion by   
$\hspace{17pt}$ imagining what they would do if they were the turtle.   
$\hspace{17pt}$ https://wikipedia.org/wiki/Logo_(programming_language)

🐬 Flipper   
$\hspace{17pt}$ Anna Prosvetova, Pavel Zhovner   
$\hspace{17pt}$ Flipper Zero is a portable multi-tool for pentesters and hardware geeks   
$\hspace{17pt}$ in a toy-like body. It loves to explore the digital world around:   
$\hspace{17pt}$ radio protocols, access control systems, hardware, and more.   
$\hspace{17pt}$ https://flipperzero.one

## Tasks

- [x] Contacts
- [x] CoreLocation
- [x] CoreMotion
- [x] CoreNFC
- [x] Data
- [x] NSNotification
- [x] Rest
- [x] Vision
- [ ] MultipeerConnectivity

The Wand may collect usage data   
You must attribute the author   
[Alex Kozin](mailto:al.kozin@gmail.com)   
[El Machine 🤖](https://el-machine.com)  
Apps since 2008
