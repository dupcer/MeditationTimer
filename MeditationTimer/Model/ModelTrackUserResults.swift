//
//  ModelTrackUserResults.swift
//  MeditationTimer
//
//  Created by Damie on 20.11.2022.
//

import Foundation


/*
 
    last date: Date
    number of consecutive days: Int
    allMeditationDates: [Date]
 
 */

class ModelTrackUserResults {
    static let shared = ModelTrackUserResults()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    var isLastMeditationYesterday: Bool {
        guard let lastDate = userDefaults.object(forKey: "lastDate") as? Date else {
            return false
        }
        
        return Calendar.current.isDateInYesterday(lastDate)
    }
    
    var numberOfConsecutiveDays: Int {
        get {
            userDefaults.object(forKey: "numberOfConsecutiveDays") as? Int ?? 0
        }
    }
    
    func addTodayAsConsecutiveDay() {
        addCurrentDateToUserDefaultsListOfMeditationDates()
        
        userDefaults.set(Date.now, forKey: "lastDate")
        
        let number = numberOfConsecutiveDays
        if number > 50 {
            userDefaults.set(51, forKey: "numberOfConsecutiveDays")
        } else {
            userDefaults.set(number+1, forKey: "numberOfConsecutiveDays")
        }
    }
    
    private func addCurrentDateToUserDefaultsListOfMeditationDates() {
        var dates: [Date] = userDefaults.object(forKey: "allMeditationDates") as? [Date] ?? []
        for d in dates {
            if d == Date.now {
                return
            }
        }
        dates.append(Date.now)
        userDefaults.set(dates, forKey: "allMeditationDates")
    }
}
