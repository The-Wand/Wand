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

#if canImport(Foundation.NSData)
import Foundation

@inline(__always)
postfix
public
func |(string: String) -> Int? {
    Int(string) ?? Int(String(string.unicodeScalars.filter(CharacterSet.decimalDigits.contains)))
}

@inline(__always)
postfix
public
func |(string: String) -> Double? {
    Double(string)
}

@inline(__always)
postfix
public
func |(string: String?) -> Data? {
    string | nil
}

@inline(__always)
public
func |(string: String?, encoding: String.Encoding?) -> Data? {
    string?.data(using: encoding ?? .utf8)
}

#endif
