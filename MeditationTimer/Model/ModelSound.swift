//
//  ModelSound.swift
//  MeditationTimer
//
//  Created by Damie on 30.10.2022.
//

import Foundation
import AVFoundation


class ModelSound {
    static let shared = ModelSound()

    private init() { }
    
    
    private let soundPlayer = SoundPlayer()
    
    var dictOfSounds: [
        String : // file name
        String   // display, discriptive name
    ] {
        get {
            populateDictOfSounds()
        }
    }
    
    private(set) var selected: String = "Audio_my1"
    
    private let noneName = "None"
    
    private func populateDictOfSounds() -> [String:String] {
        var dict: [String:String] = [noneName: noneName]
        for number in Range(1...6) {
            let name = "Audio_my\(number)"
            dict["name"] = "discriptive name \(name)"
        }

        for number in Range(0...23) {
            let name = "Audio_\(number)"
            dict["name"] = "discriptive name \(name)"
        }
        return dict
    }
    
    func selectSound(name: String) {
        selected = name
        playSound(name)
    }
    
    private func playSound(_ name: String) {
        if name == noneName {
            return
        }
        soundPlayer.playMySound(name: name)
    }
    
}
