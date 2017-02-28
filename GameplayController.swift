//
//  GameplayController.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 28/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayController {
    
    // adds the singleton
    static let instance = GameplayController()
    private init() {}
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int?
    var coin: Int?
    var life: Int?
    
    func initializeVariables(){
        
        if GameManager.instance.gameStartedFromMainMenu {
            
            GameManager.instance.gameStartedFromMainMenu = false
            
            score = 0
            coin = 0
            life = 2
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
            
        } else if GameManager.instance.gameRestartedPlayerDied {
            
            GameManager.instance.gameRestartedPlayerDied = false
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coin!)"
            lifeText?.text = "x\(life!)"
            

            
            }
            
            
        
    }
    
    

    
}
