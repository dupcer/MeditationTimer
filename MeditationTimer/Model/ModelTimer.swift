//
//  ModelTimer.swift
//  MeditationTimer
//
//  Created by Damie on 28.10.2022.
//

import Foundation

class ModelTimer {
    
    static let shared = ModelTimer()

    private init() {
        listOfTimersForSound = populateListFrom()
        
        
        func populateListFrom() -> [TimerForSound] {
            var arrToReturn: [TimerForSound] = []
            
            for id in possableIDs {
                if UserDefaults.standard.string(forKey: id) != nil {
                    let hour = UInt(UserDefaults.standard.integer(forKey: "\(id)_hour"))
                    let min = UInt(UserDefaults.standard.integer(forKey: "\(id)_minute"))
                    var soundFileName: String? = nil
                    if let fileName = UserDefaults.standard.string(forKey: "\(id)_soundFileName") {
                        soundFileName = fileName
                    }
                    
                    let newTimer = TimerForSound(
                        id: id,
                        hour: hour,
                        minute: min,
                        soundFileName: soundFileName
                    )
                    
                    arrToReturn.append(newTimer)
                    
                }
                else {
                    unusedIDs.append(id)
                }
            }
            
            return arrToReturn.sorted()
        }
    }
    
    let userDefaults = UserDefaults.standard
    private let soundPlayer = SoundPlayer()
    
    
    
    private var listOfTimersForSound: [TimerForSound] {
        didSet {
            listOfTimersForSound.sort()
            updateUserDefaults()
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
    
    func updateCurrentTimeOfTimer(minutes: UInt, hours: UInt) {
        for timer in listOfTimersForSound {
            if timer.minute == minutes, timer.hour == hours {
                if timer.soundFileName == "None" {
                    return
                }
                
                let fileName = timer.soundFileName ?? "Audio_my1"
                soundPlayer.playMySound(fileName: fileName)
            }
        }
    }

    
    private func updateUserDefaults() {
        removeTimersFromUserDefaults()
        
        for timer in listOfTimersForSound {
            let idForKey = "\(timer.id)_"
            userDefaults.set(timer.id, forKey: "\(timer.id)")
            userDefaults.set(timer.minute, forKey: "\(idForKey)minute")
            userDefaults.set(timer.hour, forKey: "\(idForKey)hour")
            if let soundFileName = timer.soundFileName {
                userDefaults.set(soundFileName, forKey: "\(idForKey)soundFileName")
            }
        }
    }
    
    private func removeTimersFromUserDefaults() {
        for i in userDefaults.dictionaryRepresentation() {
            if i.key.contains("timer_id") {
                userDefaults.removeObject(forKey: i.key)
            }
        }
    }
}


struct TimerForSound: Comparable {
    init(id: String?, hour: UInt, minute: UInt, soundFileName: String?) {
        self.hour = hour
        self.minute = minute
        self.soundFileName = soundFileName
        if id == nil {
            self.id = unusedIDs[0]
            unusedIDs.remove(at: 0)
        } else {
            self.id = id!
        }
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

fileprivate let possableIDs = ["timer_id-A", "timer_id-B", "timer_id-C"]

fileprivate var unusedIDs: [String] = []
