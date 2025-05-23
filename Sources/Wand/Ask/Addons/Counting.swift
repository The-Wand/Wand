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

extension Ask {

    /// Ask while counting
    ///
    /// |.while { (object, i) in
    ///
    /// }
    ///
    @inline(__always)
    public
    static
    func `while`(key: String? = nil,
                 handler: @escaping (T, Int)->(Bool) ) -> Ask {

        var i = 0
        return Ask(for: key) {

            defer {
                i += 1
            }
            return handler($0, i)

        }

    }

}
