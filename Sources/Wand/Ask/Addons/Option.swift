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

    /// Ask?
    /// .Option Ask don't retain Wand.Core
    public
    class Option: Ask {

        @inline(__always)
        override
        public
        func set(wand: Core?) {
        }

        @inline(__always)
        override
        public
        func optional() -> Self {
            self
        }

    }

    @inline(__always)
    public
    func dependency<U>(for key: String? = nil, on handler: ( (U) -> () )? = nil ) -> Ask<U>.Option {
        .init(once: self.once, for: key, handler: handler)
    }

    @inline(__always)
    public
    func depends<U>(for key: String? = nil, while handler: @escaping (U) -> (Bool) ) -> Ask<U>.Option {
        .init(for: key, handler: handler)
    }

}
