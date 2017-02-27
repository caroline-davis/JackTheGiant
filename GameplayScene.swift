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
    
    private var cameraDistanceBeforeCreatingNewClouds: CGFloat?
    
    let distanceBetweenClouds = CGFloat(240)
    // the side max and min so the clouds dont go outside the screen
    let minX = CGFloat(-150)
    let maxX = CGFloat(150)
    
    
    private var pausePanel: SKSpriteNode?
    
    override func didMove(to view: SKView) {
      initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches {
            let location = touch.location(in: self)
            
            
            if atPoint(location).name == "Pause" {
                self.scene?.isPaused = true
                createPausePanel()
            }
            
            if atPoint(location).name == "Resume" {
                pausePanel?.removeFromParent()
                self.scene?.isPaused = false
                return
                
            }
            
            if atPoint(location).name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // loads the scene similiar to segue
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
            
            if self.scene?.isPaused == false {
                if location.x > center! {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                } else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
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
        
        print("The random number is \(cloudsController.randomBetweenNumbers(firstNum: 2,secondNum: 5))")
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
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
    
    // respawns the new clouds for the other backgrounds
    func createNewClouds() {
        
        if cameraDistanceBeforeCreatingNewClouds! > (mainCamera?.position.y)! {
            
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            // clouds are already there - not initial!
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    
    
    func createPausePanel(){
        
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 4
        
        // sets the position of the pause panel - the panel will be the child of the camera and needs to be in the middle of the screen where the camera is.
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.height)! / 2)
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 5
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // sets the resume button into the pause panel correctly
        resumeButton.position = CGPoint(x:(pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        
        quitButton.name = "Quit"
        quitButton.zPosition = 5
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // sets the resume button into the pause panel correctly
        quitButton.position = CGPoint(x:(pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        // to show everything
        
        pausePanel?.addChild(resumeButton)
        pausePanel?.addChild(quitButton)
        
        self.mainCamera?.addChild(pausePanel!)
        
        
    }
    
}






