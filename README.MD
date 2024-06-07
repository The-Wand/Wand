
## API for Any (thing) |

### Usage
```bash

#Path to Data
"https://api.github.com/gists" | { (data: Data) in

}

#Path to [String: Any]
"https://api.github.com/gists" | { (dictionary: [String: Any]) in

}

#URL to [String: Any]
URL(string: "https://api.github.com/gists") | { (array: [Any]) in

}

#Path to [Any]
"https://api.github.com/gists" | { (array: [Any]) in

}

#URL to [Any]
URL(string: "https://api.github.com/gists") | { (array: [Any]) in

}

#REST
#Get

#Path to Dto
|.get { (model: Rest.Model) in

}

#Ask [Dto]
|{ (array: [Rest.Model]) in

}

#URL to [Dto]
url | .get { (array: [Rest.Model]) in

}

#Post

#Dto to REST.Post
dto | .post { (done: DTO) in

}

#Put

#Dto to REST.Put
dto | .put { (done: DTO) in

}

#Delete

#Dto to REST.Delete
dto | .delete { (done: DTO) in

}

```
### Idea
  Imagine that you have a black box that can give you any object 💡  
  You don't know what is already in box or what will happens inside ⚙️   
  Simply ask for objects that you need

### Сoncept

Wand started from idea about receiving anything in most efficient and fast way 🪄  
Just add on¯e sign to completion handler and retreive the result 📦  

You ideas, comments, contribution are welcome |

Tasks

- [x] Data
- [x] JsonObject
- [x] REST
- [x] URL
- [ ] Image

[Alex Kozin](mailto:al@el-machine.com)  
[El Machine 🤖](https://el-machine.com) 2024
