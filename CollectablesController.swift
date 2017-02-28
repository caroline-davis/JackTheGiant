//
//  CollectablesController.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 28/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class CollectablesController {
    
    
    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4 {
        
            if GameplayController.instance.life! < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            } else {
                collectable = SKSpriteNode(imageNamed: "Coin")
                collectable.name = "Coin"
                collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            }
            
            collectable.physicsBody?.affectedByGravity = false
            collectable.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
            collectable.physicsBody?.collisionBitMask = ColliderType.Player
            collectable.zPosition = 2
        
        }
        
        
        return collectable
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        // arc4random returns a number between 0 to (2**32)-1
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}

