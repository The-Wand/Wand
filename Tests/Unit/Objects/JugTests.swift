//
//  Tests
//
//  Created by Aleksander Kozin on 4/11/25.
//

import Testing
import Wand

struct JugTests {

    @Test
    func jug()
    {

        let jug = Jug() | { (smoke: Smoke) in
            print("aaa")
        }
        
        let container: Container = Container(Flower(52))
        
        let flower: Flower? = container|
        
        let grinded = Grinder().grind(raw: flower)
        
        let lift = Lift()
        
        lift + grinded
        
        lift + Lighter().fire()
        
        let user = User()
        
        jug + user.rod()
        
        #expect(true)
    }

    @Test
    func noFlower()
    {
        let container: Container = Container()
        let flower: Flower? = container|
    
        #expect(flower == nil)
    }
    
}
