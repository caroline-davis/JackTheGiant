//
//  OptionScene.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 15/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    override func didMove(to view: SKView) {
    
        
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
