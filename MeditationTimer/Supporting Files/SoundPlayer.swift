//
//  SoundPlayer.swift
//  MeditationTimer
//
//  Created by Damie on 31.10.2022.
//

import Foundation
import AVFoundation
var player: AVAudioPlayer?

struct SoundPlayer {
    
    func playMySound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
