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

    func addNewTimerToList(_ newValue: TimerForSound) {
        listOfTimersForSound.append(newValue)
    }
    
    func getListOfTimersForSound() -> [TimerForSound]? {
        if listOfTimersForSound.isEmpty {
            return nil
        }
        return listOfTimersForSound
    }
    
    func getTimerForSound(with id: String) -> TimerForSound? {
        for timer in listOfTimersForSound {
            if timer.id == id {
                return timer
            }
        }
        return nil
    }
    
    func addSound(withId id: String, fileName: String) {
        var i = 0
        while listOfTimersForSound.count > i {
            if listOfTimersForSound[i].id == id {
                return listOfTimersForSound[i].setSound(fileName: fileName)
            }
            i += 1
        }
    }
    
    func setTimeForTimer(withId id: String, hour: UInt, minute: UInt) {
        var i = 0
        while listOfTimersForSound.count > i {
            if listOfTimersForSound[i].id == id {
                listOfTimersForSound[i].setTime(hour: hour, minute: minute)
                return
            }
            i += 1
        }
    }

    func removeTimerFromList(with id: String) {
        var i = 0
        while listOfTimersForSound.count > i {
            if listOfTimersForSound[i].id == id {
                listOfTimersForSound.remove(at: i)
                unusedIDs.append(id)
                return
            }
            i += 1
        }
    }
        
}


struct TimerForSound: Comparable {
    init(hour: UInt, minute: UInt, soundFileName: String?) {
        self.hour = hour
        self.minute = minute
        self.soundFileName = soundFileName
        self.id = unusedIDs[0]
        unusedIDs.remove(at: 0)
    }
    
    let id: String
    var hour: UInt
    var minute: UInt
    var soundFileName: String?

    
    var totalAmountOfSeconds: Double {
        return Double( ((hour * 60) + minute) * 60 )
    }
    
    fileprivate mutating func setSound(fileName: String) {
        self.soundFileName = fileName
    }
    
    fileprivate mutating func setTime(hour: UInt, minute: UInt) {
        self.hour = hour
        self.minute = minute
    }
    
    static func < (lhs: TimerForSound, rhs: TimerForSound) -> Bool {
        lhs.totalAmountOfSeconds < rhs.totalAmountOfSeconds
    }
    
}

var unusedIDs = ["id-A", "id-B", "id-C"]
