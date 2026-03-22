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
typealias ErrorRetry = (Error, @escaping Retry)->(Bool)

public
typealias ErrorRetryCounting = (Error, @escaping Retry, Int)->(Bool)

@discardableResult
@inline(__always)
public
func |? (wand: Core, retry: @escaping ErrorRetry) -> Core {

    let ask = Ask.while(handler: retry)
    _ = wand.append(ask: ask)
    return wand
}

@discardableResult
@inline(__always)
public
func |? (wand: Core, retry: @escaping ErrorRetryCounting) -> Core {

    let ask = Ask.while(handler: retry)
    _ = wand.append(ask: ask)
    return wand
}

extension Core {

    @inline(__always)
    public
    static
    func autoretry() -> (Swift.Error, @escaping Retry, Int)->(Bool) {
        { (error: Swift.Error, retry: @escaping Retry, count: Int) in

            DispatchTime.now() + 5 | {
                retry()
            }

            return count < 1
        }
    }

}

extension Core {

    @inlinable
    public
    func error(_ error: Core.Error,
               retry: @escaping Retry) {
        add((error, retry))
        add(error)
    }

    @inlinable
    public
    func error(_ error: any Swift.Error,
               retry: @escaping Retry) {
        add((error, retry))
        add(error)
    }

}

@inline(__always)
public
func | (after: DispatchTime, execute: @escaping ()->() ) {
    DispatchQueue.main.asyncAfter(deadline: after, execute: execute)
}
