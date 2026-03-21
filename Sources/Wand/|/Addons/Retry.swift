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

public
typealias Retry = ()->()

public
typealias RetryHandler = (@escaping Retry)->(Bool)

public
typealias RetryCounting = (@escaping Retry, Int)->(Bool)

@discardableResult
public
func | (wand: Core, retry: @escaping RetryHandler) -> Core {

    let ask = Ask.while(handler: retry)
    _ = wand.append(ask: ask)
    return wand
}

@discardableResult
public
func | (wand: Core, couinting: @escaping RetryCounting) -> Core {

    let ask = Ask.while(handler: couinting)
    _ = wand.append(ask: ask)
    return wand
}

extension Core {

    @inlinable
    public
    func error(_ error: Core.Error,
               for raw: String? = nil,
               retry: @escaping Retry) {
        add(error, for: raw)
        add(retry)
    }

    @inlinable
    public
    func error(_ error: any Swift.Error,
               for raw: String? = nil,
               retry: @escaping Retry) {
        add(error, for: raw)
        add(retry)
    }

}
