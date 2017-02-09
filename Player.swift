//
//  Player.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    // all the stuff for the animation - to allow it to work
    private var textureAtlas = SKTextureAtlas()
    // the images inside the atlas
    private var playerAnimation = [SKTexture]()
    // the action that animates the player
    private var animatePlayerAction = SKAction()
    
    func initilizePlayerAnimations(){
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        // puts images in array
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
            
            print(name)
        }
        // animates the player
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
    }
    
    func animatePlayer(){
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation(){
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool) {
        if moveLeft {
            self.position.x = self.position.x - 7
        } else {
            self.position.x = self.position.x + 7
        }
    }
    
    
    
}
