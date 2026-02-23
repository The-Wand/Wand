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

/// Handle Error
///
/// wand |? { (error: Error) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |?(wand: Core, handler: @escaping (Error)->() ) -> Core {
    wand |? Ask.Option(handler: handler)
}

/// Handle Error
///
/// wand | .one { (error: Error) in
///
/// }
///
@discardableResult
@inline(__always)
public
func |?(wand: Core, ask: Ask<Error>) -> Core {

    if ask.once {

        let handler = ask.handler
        ask.handler = { [weak wand] in
            defer {
                wand?.close()
            }
            return handler($0)
        }
    }

    return wand.append(handler: ask.optional())
}

///Error codes and reasons
extension Core {

    public
    struct Error: Swift.Error {

        public
        let code: Int

        public
        let reason: String

        @inline(__always)
        public
        static
        func with(code: Int = .zero, reason: String, function: String = #function) -> Swift.Error {
            Error(code: code, reason: function + reason)
        }

        private
        init(code: Int, reason: String) {
            self.code = code
            self.reason = reason
        }

    }

}

public
extension Swift.Error {

    var code: Int {
        (self as? Core.Error)?.code ?? 0
    }

}
