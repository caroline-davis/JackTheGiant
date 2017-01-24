//
//  Player.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func movePlayer(moveLeft: Bool) {
        print("hey dudes")
        if moveLeft {
            self.position.x = self.position.x - 7
        } else {
            self.position.x = self.position.x + 7
        }
    }
    
    
    
}
