//
//  Player.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 0
    static let Cloud: UInt32 = 1
    static let DarkCloudAndCollectables: UInt32 = 2
}


class Player: SKSpriteNode {

    // all the stuff for the animation - to allow it to work
    private var textureAtlas = SKTextureAtlas()
    // the images inside the atlas
    private var playerAnimation = [SKTexture]()
    // the action that animates the player
    private var animatePlayerAction = SKAction()
    
    
    private var lastY = CGFloat()
    
    func initilizePlayerAnimations(){
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        // puts images in array
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        // animates the player
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        // physics body stuff
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = true
        // stops sprite rotating when it falls.
        self.physicsBody?.allowsRotation = false
        // stops the bouncing on the objects
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectables
        
        lastY = self.position.y
        
    }
    
    func animatePlayer(moveLeft: Bool){
        
        // changes the sprite to go the other way when walking, fabs is absolute value
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
       
    }
    
    // stops the animation and returns it to its original state, keeps size the same across the images.
    func stopPlayerAnimation(){
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool) {
        if moveLeft {
            self.position.x -= 7
        } else {
            self.position.x += 7
        }
    }
    
    func setScore() {
        if self.position.y < lastY {
            GameplayController.instance.incrementScore()
            lastY = self.position.y
        }
    }
    
    
}
