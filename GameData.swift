//
//  GameData.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 1/03/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import Foundation


class GameData: NSObject, NSCoding {
    
    struct Keys {
        
        // key, value pairs
        static let EasyDifficultyScore = "EasyDifficultyScore"
        static let MediumDifficultyScore = "MediumDifficultyScore"
        static let HardDifficultyScore = "HardDifficultyScore"
        
        static let EasyDifficultyCoinScore = "EasyDifficultyCoinScore"
        static let MediumDifficultyCoinScore = "MediumDifficultyCoinScore"
        static let HardDifficultyCoinScore = "HardDifficultyCoinScore"
        
        static let EasyDifficulty = "EasyDifficulty"
        static let MediumDifficulty = "MediumDifficulty"
        static let HardDifficulty = "HardDifficulty"
        
        static let Music = "Music"
    }
    
    // overall number score
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    // coin score
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()

    // which level was chosen
    private var easyDifficulty = false
    private var mediumDifficulty = false
    private var hardDifficulty = false

    // music
    private var isMusicOn = false
    
    override init(){}
    
    // load the data
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyScore)
        self.easyDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyCoinScore)
        
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyScore)
        self.mediumDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyCoinScore)
        
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyScore)
        self.hardDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyCoinScore)
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty)
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty)
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty)
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music)
        
    }
    
    // save the data - you can encode diff types of data - must do specifically. eg, bool, int etc
    func encode(with aCoder: NSCoder) {
        
        // saving the ints
        aCoder.encodeCInt(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore)
        aCoder.encodeCInt(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultyCoinScore)
        
        aCoder.encodeCInt(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore)
        aCoder.encodeCInt(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultyCoinScore)
        
        aCoder.encodeCInt(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore)
        aCoder.encodeCInt(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultyCoinScore)
        
        // saving the bools
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficulty)
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficulty)
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficulty)
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music)
    }
    
    // the getters and setters so we can access the variables b/c they are private
    // the easy scores
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.easyDifficultyCoinScore
    }
    
    // the medium scores
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore
    }

    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.mediumDifficultyCoinScore
    }
    
    // the hard scores
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.hardDifficultyCoinScore
    }
    
    // the level chosen
    func setEasyDifficulty(easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty
    }
    
    func setHardDifficulty(hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty
    }
    
    // music on or off
    func setIsMusicOn(isMusicOn: Bool) {
        self.isMusicOn = isMusicOn
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }
    
}
