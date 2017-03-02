//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 24/01/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudsController()
    
    var mainCamera: SKCameraNode?
    
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private let playerMinX = CGFloat(-214)
    private let playerMaxX = CGFloat(214)
    
    private var cameraDistanceBeforeCreatingNewClouds: CGFloat?
    
    let distanceBetweenClouds = CGFloat(240)
    // the side max and min so the clouds dont go outside the screen
    let minX = CGFloat(-150)
    let maxX = CGFloat(150)
    
    
    private var pausePanel: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // sets the delegate
        physicsWorld.contactDelegate = self
        initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            // play the sound for life
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
            
            // increment the life
            GameplayController.instance.incrementLife()
            // remove the life from the game
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            // play the sound for coin
             self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
            // increment the coin
            GameplayController.instance.incrementCoin()
            // remove the coin from the game
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            
            // kill the player
            self.scene?.isPaused = true
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
            GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                // show end score panel
                createEndScorePanel()
            }
            firstBody.node?.removeFromParent()
            
            // stops for 2 seconds before game restarts
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
            
            
        }
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
        
        getLabels()
        
        GameplayController.instance.initializeVariables()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        
        print("The random number is \(cloudsController.randomBetweenNumbers(firstNum: 2,secondNum: 5))")
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        setCameraSpeed()
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        // stops player falling through the left side.
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
        // stops player falling through the right side
        if (player?.position.x)! < playerMinX {
            player?.position.x = playerMinX
        }
        
        // when player is too slow the game stops.
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            print("The player is out of bounds UP")
            self.scene?.isPaused = true
            
            GameplayController.instance.life! -= 1
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                // show end panel score
                createEndScorePanel()
            }
            // stops for 2 seconds before game restarts
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        // when player falls the game stops.
        if (player?.position.y)! + (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            print("The player is out of bounds DOWN")
            self.scene?.isPaused = true
            
            GameplayController.instance.life! -= 1
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                // show end panel score
                createEndScorePanel()
            }
            // stops for 2 seconds before game restarts
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
    }
    
    // moves camera down screen
    func moveCamera() {
        
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }

        mainCamera?.position.y -= cameraSpeed
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
            
            checkForChildsOutOfScreen()
        }
    }
    
    
    // gets rid of elements off screen but keeps Backgrounds - BGs.
    func checkForChildsOutOfScreen(){
        for child in children {
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                
                let childName = child.name?.components(separatedBy: " ")
                if childName?[0] != "BG" {
                    print("The child that was removed is \(child.name)")
                    child.removeFromParent()
                }
            }
        }
    }
    
    // if you need to access a childnode make sure you mention the parent, eg mainCamera
    func getLabels(){
        GameplayController.instance.scoreText = self.mainCamera!.childNode(withName: "Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera!.childNode(withName: "Coin Score") as? SKLabelNode!
         GameplayController.instance.lifeText = self.mainCamera!.childNode(withName: "Life Score") as? SKLabelNode!
        
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
    
    func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8
        endScorePanel.xScale = 1.5
        endScorePanel.yScale = 1.5
        
        scoreLabel.fontSize = 50
        coinLabel.fontSize = 50
        
        scoreLabel.zPosition = 7
        coinLabel.zPosition = 7
        
        scoreLabel.text = "\(GameplayController.instance.score!)"
        coinLabel.text = "\(GameplayController.instance.coin!)"
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        
        // sets the endpoint panel position on screen
        endScorePanel.position = CGPoint(x: (mainCamera?.frame.size.width)! / 2, y: (mainCamera?.frame.height)! / 2)
        // sets the scores on the label
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10)
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y - 105)
        
        mainCamera?.addChild(endScorePanel)
        
    }
    
    private func setCameraSpeed() {
        
        if GameManager.instance.getEasyDifficulty() {
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        } else if GameManager.instance.getMediumDifficulty() {
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        } else if GameManager.instance.getHardDifficulty() {
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    
    }
    
    func playerDied() {
        
        // if the player has any lives left they can continue on
        if GameplayController.instance.life! >= 0 {
            
            GameManager.instance.gameRestartedPlayerDied = true
            
            let scene = GameplayScene(fileNamed: "GameplayScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // loads the scene similiar to segue
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
        } else {
            // if they have no lives we need to check if the score or coin score is a high score for whatever difficulty they player played the game at
            if GameManager.instance.getEasyDifficulty() {
                let highScore = GameManager.instance.getEasyDifficultyScore()
                let coinScore = GameManager.instance.getEasyDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setEasyDifficultyScore(GameplayController.instance.score!)
                }
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setEasyDifficultyCoinScore(GameplayController.instance.coin!)
                }
                
            } else if GameManager.instance.getMediumDifficulty() {
                let highScore = GameManager.instance.getMediumDifficultyScore()
                let coinScore = GameManager.instance.getMediumDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setMediumDifficultyScore(GameplayController.instance.score!)
                }
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setMediumDifficultyCoinScore(GameplayController.instance.coin!)
                }
                
            } else if GameManager.instance.getHardDifficulty() {
                let highScore = GameManager.instance.getHardDifficultyScore()
                let coinScore = GameManager.instance.getHardDifficultyCoinScore()
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setHardDifficultyScore(GameplayController.instance.score!)
                }
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setHardDifficultyCoinScore(GameplayController.instance.coin!)
                    
                }
            }
            // save the data and reload the main menu scene
            GameManager.instance.saveData()
            
            let scene = MainMenuScene(fileNamed: "MainMenu")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // loads the scene similiar to segue
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))

            
        }
    
    }
}






