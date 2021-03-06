//
//  CloudsController.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 14/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    let collectableController = CollectablesController()
    
    var lastCloudPositionY = CGFloat()
    
    func shuffle(cloudsArray: [SKSpriteNode]) -> [SKSpriteNode] {
        
        var shuffleArray = cloudsArray
        
        for index in 0..<shuffleArray.count {
            let randomIndex = Int(arc4random_uniform(UInt32(shuffleArray.count - index))) + index
            
            
            if index != randomIndex {
                // swaps indexes
                swap(&shuffleArray[index], &shuffleArray[randomIndex])
            }
            
            // if index == randomIndex {continue}
            // swap(&shuffleArray[index], &shuffleArray[randomIndex])
            
        }
        
        return shuffleArray
        
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        // arc4random returns a number between 0 to (2**32)-1
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        
        // looping twice
        for index in 0 ..< 2 {
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.xScale = 0.9
            cloud1.yScale = 0.9
            
            cloud2.xScale = 0.9
            cloud2.yScale = 0.9
            
            cloud3.xScale = 0.9
            cloud3.yScale = 0.9
            
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            // add physics body to the clouds
            cloud1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud1.size.width - 6, height: cloud1.size.height - 6))
            cloud1.physicsBody?.affectedByGravity = false
            cloud1.physicsBody?.restitution = 0
            cloud1.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud1.physicsBody?.collisionBitMask = ColliderType.Player
            
            cloud2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud2.size.width - 6, height: cloud2.size.height - 7))
            cloud2.physicsBody?.affectedByGravity = false
            cloud2.physicsBody?.restitution = 0
            cloud2.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud2.physicsBody?.collisionBitMask = ColliderType.Player
            
            cloud3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud3.size.width - 5, height: cloud3.size.height - 6))
            cloud3.physicsBody?.affectedByGravity = false
            cloud3.physicsBody?.restitution = 0
            cloud3.physicsBody?.categoryBitMask = ColliderType.Cloud
            cloud3.physicsBody?.collisionBitMask = ColliderType.Player
            
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf: darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
            
        }
        
        clouds = shuffle(cloudsArray: clouds)
        
        return clouds
    }
    
    
    // creates the distance between clouds on the Y axis in the correct scene.
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, player: Player, initialClouds: Bool) {
        
        var clouds = createClouds()
        
        if initialClouds {
            while(clouds[0].name == "Dark Cloud") {
                // shuffle the cloud array
                clouds = shuffle(cloudsArray: clouds)
            }
        }
       
        // current y position of cloud
        var positionY = CGFloat()
        
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90 , secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            if !initialClouds {
                
                if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 3 {
                    if clouds[i].name != "Dark Cloud" {
                        let collectable = collectableController.getCollectable()
                        collectable.position = CGPoint(x: clouds[i].position.x, y: clouds[i].position.y + 60)
                        
                        scene.addChild(collectable)
                    }
                }
            }
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
            
            if initialClouds {
                player.position = CGPoint(x: clouds[0].position.x, y: clouds[0].position.y + 9)
            }
        }
        
        
    }
    
    
    
}




