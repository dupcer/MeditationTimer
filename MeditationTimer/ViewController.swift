//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Damie on 20.10.2022.
//


import UIKit

class ViewController: UIViewController {
    
    var settingsButton: UIButton!
    var timerLabel: UILabel!
    var timerButton: UIButton!
    var resetButton: UIButton!
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var timerIsPaused: Bool = true
    var timer: Timer? = nil
    
    let settingsVC = SettingsViewController()
    let themeGetter = SetTheme(frame: UIScreen.main.bounds)
    
    private var defaultTheme: Theme {
        get {
            themeGetter.getDefaultTheme()
        }
    }
    
    private var timerButtonConfig: UIImage.SymbolConfiguration? = nil {
        willSet {
            self.timerButtonConfig = newValue
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = defaultTheme.background
        view.addSubview(themeGetter)
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        rightSwipeGestureRecognizer.direction = .right
        themeGetter.addGestureRecognizer(rightSwipeGestureRecognizer)

        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        leftSwipeGestureRecognizer.direction = .left
        themeGetter.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        timerButtonConfig = themeGetter.getDefaultTheme().buttonConfig
        
        timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        timerLabel.font = defaultTheme.font
        
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
//            timerButton.widthAnchor.constraint(equalToConstant: 150),
            timerButton.heightAnchor.constraint(equalToConstant: 150),
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30),
            timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
        ])
        
        resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.tintColor = defaultTheme.elements
        resetButton.setImage(UIImage(systemName: "gobackward"), for: .normal)
        resetButton.addTarget(self, action: #selector(resetTime), for: .touchUpInside)
        resetButton.isHidden = false
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: timerButton.leadingAnchor),
            resetButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            resetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor),
            resetButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        var settingButtonConfiguration = UIButton.Configuration.plain()
        settingButtonConfiguration.buttonSize = .medium
        settingsButton = UIButton(configuration: settingButtonConfiguration)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.tintColor = defaultTheme.elements
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            settingsButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: 16),
        ])
        
        addShadowToElements([timerLabel, resetButton])
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        print("viewWillAppear")
    }
    
    private func hideElements(_ isHidden: Bool) {
        let duration: TimeInterval = 0.75
        let delay: TimeInterval = 1
        
        if isHidden {
            UIView.animate(withDuration: duration, delay: delay, animations: {
                self.resetButton.alpha = 0
                self.settingsButton.alpha = 0
            }, completion: {_ in
                self.resetButton.isHidden = isHidden
                self.settingsButton.isHidden = isHidden
            } )
            
        } else {
            UIView.animate(withDuration: duration, delay: delay, animations: {
                self.resetButton.isHidden = isHidden
                self.settingsButton.isHidden = isHidden

                self.resetButton.alpha = 1
                self.settingsButton.alpha = 1
            })
        }
    }
    
    @objc private func buttonTimerTapped() {
        if timerIsPaused {
            hideElements(true)
            startTimer()
        } else {
            stopTimer()
            if hours + minutes + seconds != 0 {
                hideElements(false)
            }
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
        
        var min: String = "\(minutes)"
        if hours > 0, minutes < 10 {
            min = "0\(minutes)"
        }
        
        if hours == 0 {
            self.timerLabel.text = "\(min) : \(sec)"
        } else {
            self.timerLabel.text = "\(hours) : \(min) : \(sec)"
        }
    }
    
    private func updateTimerButton() {
        self.timerButton.setImage(
            timerIsPaused ?
            UIImage(systemName: "play.circle", withConfiguration: timerButtonConfig) :
            UIImage(systemName: "pause.circle", withConfiguration: timerButtonConfig),
            for: .normal
        )
    }
    
    @objc private func resetTime() {
        hours = 0
        minutes = 0
        seconds = 0
        setTextForTimerLabel()
        resetButton.isHidden = true
    }
    
    private func addShadowToElements(_ elements: [UIView]) {
        for view in elements {
            view.layer.shadowColor = defaultTheme.shadow.cgColor
            view.layer.shadowOpacity = 50
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 15
        }
    }
    
    @objc private func settingsTapped() {
        settingsVC.modalPresentationStyle = .pageSheet
        if let sheet = settingsVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            
        }
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    
    private func applyNewTheme(_ theme: Theme, next animateToRight: Bool) {
        UIView.transition(
            with: self.view,
            duration: 0.3,
          options: animateToRight ? .transitionFlipFromRight : .transitionFlipFromLeft,
            animations: {
                self.view.backgroundColor = theme.background
                self.timerLabel.textColor = theme.elements
                self.timerLabel.font = theme.font
                self.timerButtonConfig = theme.buttonConfig
                self.updateTimerButton()
                self.resetButton.tintColor = theme.elements
                self.settingsButton.tintColor = theme.elements
            }
        )
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            if let newTheme = themeGetter.getNewTheme(next: true) {
                applyNewTheme(newTheme, next: true)
            }
        default: // .right
            if let newTheme = themeGetter.getNewTheme(next: false) {
                applyNewTheme(newTheme, next: false)
            }
        }
    }
    

}

