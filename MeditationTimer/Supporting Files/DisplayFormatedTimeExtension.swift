//
//  DisplayFormatedTimeExtension.swift
//  MeditationTimer
//
//  Created by Damie on 30.10.2022.
//

import UIKit

protocol DisplayFormatedTimeExtension {
    func getFormattedTimer(_ timer: TimerForSound, stringPrefix: String) -> String
    func getShortedFormattedTimer(_ timer: TimerForSound) -> String
}

extension DisplayFormatedTimeExtension {
    func getFormattedTimer(_ timer: TimerForSound, stringPrefix: String = "Timer: ") -> String {
/*
     Timer: 1 minute
     Timer: 15 minutes
     Timer: 1 hour 5 minutes
     Timer: 1 hour 30 minutes
 */
        var minutes: String = "minutes"
        if timer.minute == 0 {
            minutes = "minute"
        }

        if timer.hour == 0 {
            return String("\(stringPrefix)\(timer.minute) \(minutes)")
        }
        return String("\(stringPrefix)\(timer.hour) hour \(timer.minute) \(minutes)")

    }
    
    
    func getShortedFormattedTimer(_ timer: TimerForSound) -> String {
/*
     3 min
     15 min
     1:05 min
     1:30 min
 */
        if timer.hour == 0 {
            return String("\(timer.minute) min")
        } else if timer.hour > 0, timer.minute < 10 {
            return String("\(timer.hour):0\(timer.minute) min")
        }
        return String("\(timer.hour):\(timer.minute) min")
    }
    
    func getFormattedTimerForEmpty(stringPrefix: String) -> String {
        return ""
    }
}
