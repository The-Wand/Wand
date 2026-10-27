//
//  Tests
//
//  Created by Aleksander Kozin on 4/11/25.
//

import Testing
import Wand

struct VultureTests {

    @Test
    func launch()
    {
        let vulture: Vulture? = Vulture()
        #expect(vulture != nil)
    }
    
}
