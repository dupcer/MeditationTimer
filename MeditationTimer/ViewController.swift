//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Damie on 20.10.2022.
//


import UIKit

class ViewController: UIViewController {
    
    var timerLabel: UILabel!
    var buttonStartTimer: UIButton!
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var timerIsPaused: Bool = true
    
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 42)
        timerLabel.text = getTextForTimerLabel()
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        buttonStartTimer = UIButton()
        buttonStartTimer.translatesAutoresizingMaskIntoConstraints = false
        buttonStartTimer.tintColor = UIColor(ciColor: .gray)
        buttonStartTimer.setImage(
            timerIsPaused ? UIImage(systemName: "play.circle") : UIImage(systemName: "pause.circle"), for: .normal
        )
        view.addSubview(buttonStartTimer)
        
        NSLayoutConstraint.activate([
            buttonStartTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStartTimer.topAnchor.constraint(equalTo: timerLabel.bottomAnchor),
            buttonStartTimer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),

        ])
        
    }
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                } else {
                    self.minutes = self.minutes + 1
                }
            } else {
                self.seconds = self.seconds + 1
            }
        }
    }
    
    func stopTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    private func getTextForTimerLabel() -> String {
        if hours == 0, timerIsPaused {
            return "0 : 00"
        } else if hours == 0, !timerIsPaused {
            return "\(minutes) : \(seconds)"
        }
        return "\(hours) : \(minutes) : \(seconds)"
    }
    
    
}

