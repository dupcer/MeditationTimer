//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Damie on 20.10.2022.
//


import UIKit

class ViewController: UIViewController {
    
    var timerLabel: UILabel!
    var timerButton: UIButton!
    
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
        timerLabel.font = UIFont.scriptFont(size: 42)
        setTextForTimerLabel()
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        

        
        
        timerButton = UIButton()
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        timerButton.addTarget(self, action: #selector(buttonTimerTapped), for: .touchUpInside)
        updateTimerButton()
        view.addSubview(timerButton)
        
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor),
            timerButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
    
    
    @objc private func buttonTimerTapped() {
        if timerIsPaused {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    private func startTimer(){
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
            self.setTextForTimerLabel()
            self.updateTimerButton()
        }
    }
    
    private func stopTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
        updateTimerButton()
    }
    
    private func setTextForTimerLabel() {
        var sec: String = "\(seconds)"
        if seconds < 10 {
            sec = "0\(seconds)"
        }
        
        if hours == 0 {
            self.timerLabel.text = "\(minutes) : \(sec)"
        } else {
            self.timerLabel.text = "\(hours) : \(minutes) : \(sec)"
        }
    }
    
    private func updateTimerButton() {
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemGray])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 60)))
        config = config.applying(UIImage.SymbolConfiguration(weight: .ultraLight))
        
        
        self.timerButton.setImage(
            timerIsPaused ?
            UIImage(systemName: "play.circle", withConfiguration: config) :
            UIImage(systemName: "pause.circle", withConfiguration: config),
            for: .normal
        )
    }
    
    
}

