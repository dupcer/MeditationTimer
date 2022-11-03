//
//  ModelSound.swift
//  MeditationTimer
//
//  Created by Damie on 30.10.2022.
//

import Foundation


class ModelSound {
    static let shared = ModelSound()

    private init() { }
    
    
    private let soundPlayer = SoundPlayer()

    let AllSounds: [[String]] = [
        arrayOfSoundNone, arrayOfSoundsMy, arrayOfSoundsOthers
    ]
    
    func getDescriptiveName(_ name: String?) -> String {
        let defaultName = "Default"
        
        guard let name = name else {
            return dictionaryOfSoundsMy["Audio_my1"] ?? defaultName
        }
        
        if name.contains("None") {
            return dictionaryOfSoundsNone[name] ?? defaultName
        } else if name.contains("my") {
            return dictionaryOfSoundsMy[name] ?? defaultName
        } else {
            return dictionaryOfSoundsOthers[name] ?? defaultName
        }
    }
    
    func getSectionAndItemOfNameForTable(_ name: String) -> (section:Int, item:Int) {
        if name.contains("None") {
            return (section: 0, item: 0)
        } else if name.contains("my") {
            return (section: 1, item: arrayOfSoundsMy.firstIndex(of: name) ?? 0)
        } else {
            return (section: 2, item: arrayOfSoundsOthers.firstIndex(of: name) ?? 0)
        }
    }
    
    private(set) var selected: String = "Audio_my1"
    
    private let noneName = "None"
    
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

fileprivate let arrayOfSoundNone = ["None"]
fileprivate let dictionaryOfSoundsNone: [String:String] =
[
    "None": "None",
]

fileprivate let arrayOfSoundsMy: [String] = [
    "Audio_my1", "Audio_my2", "Audio_my3", "Audio_my4", "Audio_my5", "Audio_my6"
]
fileprivate let dictionaryOfSoundsMy: [String:String] =
[
    "Audio_my1": "Default",
    "Audio_my2": "discriptive name Audio_my2",
    "Audio_my3": "discriptive name Audio_my3",
    "Audio_my4": "discriptive name Audio_my4",
    "Audio_my5": "discriptive name Audio_my5",
    "Audio_my6": "discriptive name Audio_my6"
]

fileprivate let arrayOfSoundsOthers: [String] = [
    "Audio_0", "Audio_1", "Audio_2", "Audio_3", "Audio_4", "Audio_5", "Audio_6", "Audio_7", "Audio_8", "Audio_9", "Audio_10", "Audio_11", "Audio_12", "Audio_13", "Audio_14", "Audio_15", "Audio_16", "Audio_17", "Audio_18", "Audio_19", "Audio_20", "Audio_21", "Audio_22", "Audio_23"
]

fileprivate let dictionaryOfSoundsOthers: [String:String] =
[
    "Audio_0": "discriptive name Audio_0",
    "Audio_1": "discriptive name Audio_1",
    "Audio_2": "discriptive name Audio_2",
    "Audio_3": "discriptive name Audio_3",
    "Audio_4": "discriptive name Audio_4",
    "Audio_5": "discriptive name Audio_5",
    "Audio_6": "discriptive name Audio_6",
    "Audio_7": "discriptive name Audio_7",
    "Audio_8": "discriptive name Audio_8",
    "Audio_9": "discriptive name Audio_9",
    "Audio_10": "discriptive name Audio_10",
    "Audio_11": "discriptive name Audio_11",
    "Audio_12": "discriptive name Audio_12",
    "Audio_13": "discriptive name Audio_13",
    "Audio_14": "discriptive name Audio_14",
    "Audio_15": "discriptive name Audio_15",
    "Audio_16": "discriptive name Audio_16",
    "Audio_17": "discriptive name Audio_17",
    "Audio_18": "discriptive name Audio_18",
    "Audio_19": "discriptive name Audio_19",
    "Audio_20": "discriptive name Audio_20",
    "Audio_21": "discriptive name Audio_21",
    "Audio_22": "discriptive name Audio_22",
    "Audio_23": "discriptive name Audio_23",
]
