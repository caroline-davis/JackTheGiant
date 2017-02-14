//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var cloudsController = CloudsController()
    
    var mainCamera: SKCameraNode?
    
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(85)
    let maxX = CGFloat(392)
    
    override func didMove(to view: SKView) {
      initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("i stopped touching")
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initializeVariables(){
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player
        player?.initilizePlayerAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackgrounds()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG1") as? BGClass!
        bg2 = self.childNode(withName: "BG2") as? BGClass!
        bg3 = self.childNode(withName: "BG3") as? BGClass!
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    // moves camera down screen
    func moveCamera() {
        self.mainCamera?.position.y -= 3
    }
    
    func manageBackgrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
}
