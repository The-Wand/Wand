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

/// Init with Dictionary
extension Core: ExpressibleByDictionaryLiteral {

    @inline(__always)
    convenience
    public
    init(dictionaryLiteral elements: (String, Any)...) {

        self.init()

        elements.forEach { (key, object) in

            Core[object as AnyObject] = self
            context[key] = object
        }
    }

    @inline(__always)
    convenience
    public
    init(dictionary: [String: Any]) {

        self.init()

        dictionary.forEach { (key, object) in

            Core[object as AnyObject] = self
            context[key] = object
        }
    }

}
