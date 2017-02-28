//
//  MainMenuScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 15/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit


class MainMenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start Game" {
                
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // loads the scene similiar to segue
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
            if atPoint(location).name == "Highscore" {
               let scene = HighscoreScene(fileNamed: "HighscoreScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // loads the scene similiar to segue
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
            if atPoint(location).name == "Option" {
                let scene = OptionScene(fileNamed: "OptionScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // loads the scene similiar to segue
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
            }
            
        }
    }
    
    
}


// if this is what is being touched, then do that one.
// another way - var highScoreBtn: SKSpriteNode? under class and in didMove put: highScoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode!... then... if atPoint(location) == highScoreBtn ( print bla }
