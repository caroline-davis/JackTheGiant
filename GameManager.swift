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
    
    private var gameData: GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
    func initializeGameData() {
        
        if !FileManager.default.fileExists(atPath: getFilePath() as String) {
            // set up our game with initial values if there is no file path eg, they havent played the game before
            gameData = GameData()
            
            gameData?.setEasyDifficultyScore(easyDifficultyScore: 0)
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0)
            
            gameData?.setMediumDifficultyScore(mediumDifficultyScore: 0)
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0)
            
            gameData?.setHardDifficultyScore(hardDifficultyScore: 0)
            gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: 0)
            
            gameData?.setEasyDifficulty(easyDifficulty: false)
            gameData?.setMediumDifficulty(mediumDifficulty: true)
            gameData?.setHardDifficulty(hardDifficulty: false)
            
            gameData?.setIsMusicOn(isMusicOn: false)
            
            saveData()
        }
        
        loadData()
        
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData
    }
    
    func saveData() {
        if gameData != nil {
        NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String)
        }
    }
    
    private func getFilePath() -> String {
        
        let manager = FileManager.default
        // gets the first url in the array
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return url!.appendingPathComponent("Game Manager").path
        print(getFilePath())
    
    }
    
    // the getters and setters so we can access the variables b/c they are private
    // the easy scores
    func setEasyDifficultyScore(_ easyDifficultyScore: Int32) {
        gameData!.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore);
    }
    
    func setEasyDifficultyCoinScore(_ easyDifficultyCoinScore: Int32) {
        gameData!.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyCoinScore);
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return gameData!.getEasyDifficultyScore();
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return gameData!.getEasyDifficultyCoinScore();
    }
    
    // the medium scores
    func setMediumDifficultyScore(_ mediumDifficultyScore: Int32) {
        gameData!.setMediumDifficultyScore(mediumDifficultyScore: mediumDifficultyScore);
    }
    
    func setMediumDifficultyCoinScore(_ mediumDifficultyCoinScore: Int32) {
        gameData!.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumDifficultyCoinScore);
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return gameData!.getMediumDifficultyScore();
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return gameData!.getMediumDifficultyCoinScore();
    }
    
    // the hard scores
    func setHardDifficultyScore(_ hardDifficultyScore: Int32) {
        gameData!.setHardDifficultyScore(hardDifficultyScore: hardDifficultyScore);
    }
    
    func setHardDifficultyCoinScore(_ hardDifficultyCoinScore: Int32) {
        gameData!.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardDifficultyCoinScore);
    }
    
    func getHardDifficultyScore() -> Int32 {
        return gameData!.getHardDifficultyScore();
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return gameData!.getHardDifficultyCoinScore();
    }
    
    // the level chosen
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        gameData!.setEasyDifficulty(easyDifficulty: easyDifficulty);
    }
    
    func getEasyDifficulty() -> Bool {
        return gameData!.getEasyDifficulty();
    }
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        gameData!.setMediumDifficulty(mediumDifficulty: mediumDifficulty);
    }
    
    func getMediumDifficulty() -> Bool {
        return gameData!.getMediumDifficulty();
    }
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        gameData!.setHardDifficulty(hardDifficulty: hardDifficulty);
    }
    
    func getHardDifficulty() -> Bool {
        return gameData!.getHardDifficulty();
    }
    
    // the music on/off
    func setIsMusicOn(_ isMusicOn: Bool) {
        gameData!.setIsMusicOn(isMusicOn: isMusicOn);
    }
    
    func getIsMusicOn() -> Bool {
        return gameData!.getIsMusicOn();
    }
    

    
}
