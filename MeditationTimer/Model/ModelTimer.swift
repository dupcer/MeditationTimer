//
//  ModelTimer.swift
//  MeditationTimer
//
//  Created by Damie on 28.10.2022.
//

import Foundation

class ModelTimer {
    
    static let shared = ModelTimer()

    private init() { }

    
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
    
    func addSound(indexInList: Int, fileName: String) {
        if self.listOfTimersForSound.isEmpty {
            return
        }
        
        self.listOfTimersForSound[indexInList].setSound(fileName: fileName)
    }
}


struct TimerForSound: Comparable {
    init(hour: UInt, minute: UInt, soundFileName: String?) {
        self.hour = hour
        self.minute = minute
        self.soundFileName = soundFileName
    }
    
    var hour: UInt
    var minute: UInt
    var soundFileName: String?

    
    var totalAmountOfSeconds: Double {
        return Double( ((hour * 60) + minute) * 60 )
    }
    
    fileprivate mutating func setSound(fileName: String) {
        self.soundFileName = fileName
    }
    
    static func < (lhs: TimerForSound, rhs: TimerForSound) -> Bool {
        lhs.totalAmountOfSeconds < rhs.totalAmountOfSeconds
    }
    
}
