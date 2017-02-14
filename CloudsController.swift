//
//  CloudsController.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 14/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat()
    
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
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
            
        }
        
        return clouds
    }
    
    
    // creates the distance between clouds on the Y axis in the correct scene.
    func arrangeCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        
        var clouds = createClouds()
        
        if initialClouds {
            while(clouds[0].name == "Dark Cloud") {
                // shuffle the cloud array
            }
        }
       
        // current y position of cloud
        var positionY = CGFloat()
        
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        for i in 0...clouds.count - 1 {
            clouds[i].position = CGPoint(x: 0, y: positionY)
            clouds[i].zPosition = 3
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
        }
        
        
    }
    
    
    
}

