//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    override func didMove(to view: SKView) {
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = self.childNode(withName: "Player") as? Player
        print("player", player)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("i touched")
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
            } else {
                moveLeft = true
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("i stopped touching")
        canMove = false
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
}
