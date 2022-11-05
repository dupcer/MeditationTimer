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
    
    func playMySound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else {
                return
            }
            
            player.play()

            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
