//
//  ModelSettings.swift
//  MeditationTimer
//
//  Created by Damie on 10.11.2022.
//

import Foundation

class ModelSettings {
    static let shared = ModelSettings()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    var DimSetting: Bool {
        get {
            userDefaults.object(forKey: "DimSetting") as? Bool ?? false
        } set {
            userDefaults.set(newValue, forKey: "DimSetting")
        }
    }
    
}
