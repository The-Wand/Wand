///
/// Copyright 2569 Aleksander Kozin
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

final
public
class Retry: Fix, Expecting {
    
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
