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

#if DEBUG
public
enum Log: Int {

    case none
    case info
    case warning
    case verbose

    public
    static
    let `default` = Log.info

    public
    static
    var level = Log.default

}

extension Log: Comparable {

    @inlinable
    public
    static
    func < (lhs: Log, rhs: Log) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

}

extension Core {

    @inlinable
    public
    func log(_ message: String, to level: Log = .verbose) {
        if Log.level > .none && Log.level >= level {
            print(message + "\n" + description + "\n")
        }
    }

}

#else

extension Core {

    @inline(__always)
    internal
    func log(_ message: String) {
    }

}

#endif

