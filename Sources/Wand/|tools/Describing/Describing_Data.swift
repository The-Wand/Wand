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

///Data
#if canImport(Foundation)
import Foundation.NSData

@inline(__always)
postfix
public
func |(data: Data) -> String {
    (data | nil)!
}

@inline(__always)
postfix
public
func |(data: Data) -> String? {
    data | nil
}

@inline(__always)
public
func |(data: Data, encoding: String.Encoding) -> String {
    (data | encoding)!
}

@inline(__always)
public
func |(data: Data, encoding: String.Encoding?) -> String? {
    String(data: data, encoding: encoding ?? .utf8)
}

#endif
