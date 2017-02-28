//
//  GameManager.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 28/02/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import Foundation

class GameManager {
    
    // adds the singleton
    static let instance = GameManager()
    private init() {}
    
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
}
