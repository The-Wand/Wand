
# ``Wand``

Swift implementation of declarative approach. 
Use pipeline syntax to receive <#Any#> object. 
Bus for <#Any#> Factory + Cache.

```swift
| .one { (t: <#T#>) in 

} | .every { (u: <#U#>) in
 
} | .while { (v: <#V#>) in 

} | { (error: Error) in

} | .all { _ in

}
```

@version 3
## Overview

Call the operator with handler to receive only one object:
```swift
|{ (t: <#T#>) in 

}
```

Use labels to specify behaviour:
- **One** to receive an object and stop
```swift
| .one { (t: <#T#>) in 

}
```

- **Every** for continius updates
```swift
| .every { (t: <#T#>) in 

}
```

- **While** handler returns **true**
```swift
| .while { (t: <#T#>) in 

}
```
