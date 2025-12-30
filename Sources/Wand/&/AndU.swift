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

@inline(__always)
public
func &<T: Ask.T, U: Ask.T> (ask: Ask<T>, appending: @escaping (U)->() ) -> Ask<T> {

    let saved = ask.handler
    ask.handler = {

        let result = saved($0)
        ask.core |? appending
        ask.handler = saved

        return result
    }

    return ask
}

@inline(__always)
public
func &<T: Ask.T, U: Ask.T> (ask: Ask<T>, appending: @escaping (U)->(Bool) ) -> Ask<T> {

    let saved = ask.handler
    ask.handler = {

        let result = saved($0)
        ask.core | ask.depends(while: appending)
        ask.handler = saved

        return result
    }

    return ask
}
