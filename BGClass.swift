//
//  BGClass.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 9/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
    }
    
 
    
    
}
