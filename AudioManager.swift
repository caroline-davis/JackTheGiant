//
//  AudioManager.swift
//  JackTheGiant
//
//  Created by Caroline Davis on 2/03/2017.
//  Copyright © 2017 Caroline Davis. All rights reserved.
//

import AVFoundation

class AudioManager {
    
    static let instance = AudioManager()
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBGMusic() {
        
        // finds the music
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3")
        
        // incase file doesnt exist we can catch the error
        var error: NSError?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            // if you put -1 it will loop forever
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        } catch let error1 as NSError {
            error = error1
        }
        if error != nil {
            print("we have a problem")
        }
        
    }
    
    func stopBgMusic(){
        
        if audioPlayer?.isPlaying != nil {
            audioPlayer?.stop()
        }
        
    }
    
    
}
