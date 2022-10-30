//
//  ModelTimer.swift
//  MeditationTimer
//
//  Created by Damie on 28.10.2022.
//

import Foundation

class ModelTimer {
    
    private var listOfTimersForSound: [TimerForSound] = [] {
        didSet {
            listOfTimersForSound.sort()
        }
    }

    func addNewTimerToList(_ newValue: TimerForSound, indexPathItem index: Int) {
        if index > listOfTimersForSound.count-1 {
            listOfTimersForSound.append(newValue)
        } else {
            listOfTimersForSound[index] = newValue
        }
    }
    
    func getListOfTimersForSound() -> [TimerForSound]? {
        if listOfTimersForSound.isEmpty {
            return nil
        }
        return listOfTimersForSound
    }
    
    func removeTimerFromList(_ index: Int) {
        if listOfTimersForSound.indices.contains(index) {
            listOfTimersForSound.remove(at: index)
        }
    }
}


struct TimerForSound: Comparable {
    static func < (lhs: TimerForSound, rhs: TimerForSound) -> Bool {
        lhs.totalAmountOfSeconds < rhs.totalAmountOfSeconds
    }
    
    var hour: UInt
    var minute: UInt
    
    init(hour: UInt, minute: UInt) {
        self.hour = hour
        self.minute = minute
    }
    
    var totalAmountOfSeconds: Double {
        return Double( ((hour * 60) + minute) * 60 )
    }
}
