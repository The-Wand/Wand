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
struct Retry: Expecting {

    let block: ()->()
    let reason: Any?

    @inline(__always)
    public
    func callAsFunction() {
        block()
    }

}

public
extension Retry {

    @inline(__always)
    static
    func after(_ timeout: Double, attempts: Int = 2) -> Ask<Retry> {
        .while { (retry: Retry, count: Int) in

            DispatchTime.now() + timeout | {
                retry()
            }
            return count < attempts - 1
        }
    }

    @inline(__always)
    static
    func auto() -> Ask<Retry> {
        after(5)
    }

}

public
extension Core {

    @inline(__always)
    func add(_ error: any Swift.Error, retry: @escaping ()->()) {
        add(Retry(block: retry, reason: add(error)))
    }

}
