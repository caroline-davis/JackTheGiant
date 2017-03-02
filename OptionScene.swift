//
//  OptionScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 15/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyBtn: SKSpriteNode?
    private var mediumBtn: SKSpriteNode?
    private var hardBtn: SKSpriteNode?
    
    private var sign: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        initializeVariables()
        
    }
    
    func initializeVariables() {
        easyBtn = childNode(withName: "Easy") as? SKSpriteNode
        mediumBtn = childNode(withName: "Medium") as? SKSpriteNode
        hardBtn = childNode(withName: "Hard") as? SKSpriteNode
        sign = childNode(withName: "Sign") as? SKSpriteNode
    }
    
    // sets initial checkpoint if they have opened the game before
    func setSign() {
        if GameManager.instance.getEasyDifficulty() == true {
            sign?.position.y = (easyBtn?.position.y)!
        } else if GameManager.instance.getMediumDifficulty() == true {
            sign?.position.y = (mediumBtn?.position.y)!
        } else if GameManager.instance.getHardDifficulty() == true {
            sign?.position.y = (hardBtn?.position.y)!
        }
        
    }
    
    private func setDifficulty(difficulty: String) {
        switch(difficulty) {
        case "easy":
            GameManager.instance.setEasyDifficulty(true)
            GameManager.instance.setMediumDifficulty(false)
            GameManager.instance.setHardDifficulty(false)
            break
        case "medium":
            GameManager.instance.setEasyDifficulty(false)
            GameManager.instance.setMediumDifficulty(true)
            GameManager.instance.setHardDifficulty(false)
            break
        case "hard":
            GameManager.instance.setEasyDifficulty(false)
            GameManager.instance.setMediumDifficulty(false)
            GameManager.instance.setHardDifficulty(true)
            break
        default:
            break
        }
        
        GameManager.instance.saveData()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if nodes(at: location)[0] == easyBtn {
                sign!.position.y = easyBtn!.position.y;
                setDifficulty(difficulty: "easy");
            }
            
            if nodes(at: location)[1] == mediumBtn {
                sign!.position.y = mediumBtn!.position.y;
                setDifficulty(difficulty: "medium");
            }
            
            if nodes(at: location)[2] == hardBtn {
                sign!.position.y = hardBtn!.position.y;
                setDifficulty(difficulty: "hard");
            }
            
            sign?.zPosition = 4
            
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
