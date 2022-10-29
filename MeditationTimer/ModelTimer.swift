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
    
    private var listOfTimersForSound: [TimerForSound] = [] {
        didSet {
            listOfTimersForSound.sort()
        }
    }

    
    func addNewTimerToList(_ newValue: TimerForSound, indexPathItem withIndex: Int) {
        listOfTimersForSound.append(newValue)
    }
    
    func getListOfTimersForSound() -> [TimerForSound]? {
        if listOfTimersForSound.isEmpty {
            return nil
        }
        return listOfTimersForSound
    }
}


struct TimerForSound: Comparable {
    static func < (lhs: TimerForSound, rhs: TimerForSound) -> Bool {
        lhs.numberToOrder < rhs.numberToOrder
    }
    
    var hour: UInt
    var minute: UInt
    
    init(hour: UInt, minute: UInt) {
        self.hour = hour
        self.minute = minute
    }
    
    fileprivate var numberToOrder: Int {
        return Int(hour)*100 + Int(minute)
    }
}
