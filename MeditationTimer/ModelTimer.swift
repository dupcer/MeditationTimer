//
//  ModelTimer.swift
//  MeditationTimer
//
//  Created by Damie on 28.10.2022.
//

import Foundation

class ModelTimer {
    
    private var currentTimeHours: UInt = 0
    private var currentTimeMinutes: UInt = 0
    
    private var listOfTimersForSound: [TimerForSound?] = []
    
    func addNewTimerToList(_ newValue: TimerForSound) {
        listOfTimersForSound.append(newValue)
    }
    
    func getListOfTimersForSound() -> [TimerForSound]? {
        if listOfTimersForSound.isEmpty {
            return nil
        }
        return listOfTimersForSound.map({ $0! })
    }
}


struct TimerForSound {
    var hour: UInt
    var minute: UInt
}
