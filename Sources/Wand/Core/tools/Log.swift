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


public
enum Log: Int {

    case none
    case verbose
    case warning
    case info

    public
    static
    var level = Log.default

    public
    static
    let `default` = Log.none

    @inlinable
    public
    func callAsFunction(_ message: String) {
#if DEBUG
        let level = Log.level
        if level > .none && .verbose...level ~= self {
            Swift.print(message)
        }
#endif
    }

}

#if DEBUG
extension Log: Comparable {

    @inlinable
    public
    static
    func < (lhs: Log, rhs: Log) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

}
#endif
