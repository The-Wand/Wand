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

extension Ask {

    /// .Option Ask don't retain Wand.Core
    public
    class Option: Ask {

        @inline(__always)
        override
        public
        func set(core: Core?) -> Bool {
            check
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
    func dependency<U>(for key: String? = nil,
                       check: Bool = false,
                       on handler: ( (U)->() )? = nil ) -> Ask<U>.Option {
        let ask = Ask<U>.Option(once: self.once, for: key, handler: handler)
        ask.check = check
        return ask
    }

}
