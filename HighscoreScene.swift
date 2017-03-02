//
//  HighscoreScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 15/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var coinLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        getReference()
        setScore()
        
    }
    
    private func getReference(){
        scoreLabel = self.childNode(withName: "Score Label") as! SKLabelNode?
        coinLabel = self.childNode(withName: "Coin Label") as! SKLabelNode?
    }
    
    private func setScore() {
        
        // setting the text of the score/coin label
        if GameManager.instance.getEasyDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getEasyDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getEasyDifficultyCoinScore())
        } else if GameManager.instance.getMediumDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getMediumDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getMediumDifficultyCoinScore())
         } else if GameManager.instance.getHardDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getHardDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getHardDifficultyCoinScore())
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // loads the scene similiar to segue
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
        }
    }
    
    
    
    
}
