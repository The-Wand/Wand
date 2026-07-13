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
/// .some

import Foundation

extension String: Some {
    
    public
    static
    var rand: Self {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non gravida felis. Vivamus interdum massa nulla, eu egestas ipsum eleifend non. Ut vel augue et orci fermentum consequat eget nec est. Aenean eleifend tempor nibh, a posuere lacus pharetra non. Praesent elementum ac urna convallis porttitor.".components(separatedBy: " ").randomElement()!
    }

}
