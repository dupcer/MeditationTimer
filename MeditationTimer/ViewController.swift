//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Damie on 20.10.2022.
//


import UIKit
let blurStyleForElements: UIBlurEffect.Style = .regular

class ViewController: UIViewController {
    
    var settingsButton: UIButton!
    var timerLabel: UILabel!
    var timerButton: UIButton!
    var resetButton: UIButton!
    var themeNameLabel: UILabel!
    var doneButton: UIButton!
    
    var hours: UInt = 0
    var minutes: UInt = 0
    var seconds: UInt = 55
    var timerIsPaused: Bool = true
    var timer: Timer? = nil
    

    let timersListVC = MainScreenTimersListViewController()
    let settingsVC = SettingsTableViewController()
    let themeGetter = SetTheme(frame: UIScreen.main.bounds)
    let resultsVC = ResultsViewController(blurStyle: blurStyleForElements)
    var blurEffectView: UIVisualEffectView!
    
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
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(showSettings))
        swipeUpGestureRecognizer.direction = .up
        themeGetter.addGestureRecognizer(swipeUpGestureRecognizer)
        
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
        resetButton.isHidden = true
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
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
        settingsButton.setImage(image, for: .normal )
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
        
        themeNameLabel = UILabel()
        themeNameLabel.isHidden = true
        themeNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.addSubview(themeNameLabel)
        themeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themeNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / 10),
        ])
        
        addShadowToElements([timerLabel, resetButton])
        
        timersListVC.view.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showSettings))
        timersListVC.view.addGestureRecognizer(guestureRecognizer)
        addChild(timersListVC)
        view.addSubview(timersListVC.view)
        
        timersListVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timersListVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timersListVC.view.bottomAnchor.constraint(equalTo: timerLabel.topAnchor),
            timersListVC.view.widthAnchor.constraint(equalToConstant: 150),
            timersListVC.view.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        settingsVC.vcToUpdate = timersListVC
        
        
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        blurEffectView.isHidden = true
        let blurEffectGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(alertToAskToStartAgain))
        blurEffectView.addGestureRecognizer(blurEffectGuestureRecognizer)

        
        resultsVC.view.clipsToBounds = true
        resultsVC.view.layer.cornerRadius = 25
        addChild(resultsVC)
        view.addSubview(resultsVC.view)
        resultsVC.view.isHidden = true
        
        var doneButtonConfig = UIButton.Configuration.borderless()
        doneButtonConfig.background.visualEffect = UIBlurEffect(style: .regular)
        doneButtonConfig.buttonSize = .small
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 18)
        doneButtonConfig.attributedTitle = AttributedString("Done", attributes: container)

        doneButton = UIButton(configuration: doneButtonConfig)
        doneButton.isHidden = true
        doneButton.tintColor = .label
        doneButton.layer.cornerRadius = 25
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: timerButton.trailingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            doneButton.topAnchor.constraint(equalTo: timerButton.topAnchor, constant: 35),
            doneButton.bottomAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: -35),
        ])
    }
    
    
    private func hideElements(_ isHidden: Bool) {
        let duration: TimeInterval = 0.75
        let delay: TimeInterval = 1

        if isHidden {
            UIView.animate(withDuration: duration, delay: delay, animations: {
                self.resetButton.alpha = 0
                self.settingsButton.alpha = 0
                self.doneButton.alpha = 0
            }, completion: {_ in
                self.resetButton.isHidden = isHidden
                self.settingsButton.isHidden = isHidden
                self.doneButton.isHidden = isHidden
            } )
            
        } else {
            UIView.animate(withDuration: duration, delay: delay, animations: {
                self.resetButton.isHidden = isHidden
                self.settingsButton.isHidden = isHidden
                
                self.resetButton.alpha = 1
                self.settingsButton.alpha = 1
                
                if self.minutes > 0 || self.hours > 0 {
                    self.doneButton.isHidden = isHidden
                    self.doneButton.alpha = 1
                }
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
        updateTimerButton()
        timing()
    }
    
    private func stopTimer(){
        timerIsPaused = true
        updateTimerButton()
        timer?.invalidate()
        timer = nil
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
    
    @objc private func showSettings() {
        let navVC = UINavigationController(rootViewController: settingsVC)
        navVC.modalPresentationStyle = .pageSheet
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        self.present(navVC, animated: true, completion: nil)
    }
    
    @objc private func doneButtonTapped() {
        showResultsView()
        self.doneButton.isUserInteractionEnabled = false
        UIView.transition(
            with: self.doneButton,
            duration: 0.7,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.doneButton.setTitle("", for: .normal)
                
                self?.doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                self?.doneButton.tintColor = .green
            }, completion: { _ in
                UIView.animate(withDuration: 1.2, delay: 1, animations: { [weak self] in
                    self?.doneButton.tintColor = .label
                }
                )
            }
        )
    }
    
    private func showResultsView() {
        guard let resultView = resultsVC.view else {
            return
        }

        resultsVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -15),
            resultView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3, constant: -30),
            resultView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
        
        self.blurEffectView.alpha = 0
        self.resultsVC.view.alpha = 0
        
        self.blurEffectView.isHidden = false
        self.resultsVC.view.isHidden = false

        UIView.transition(
            with: self.view,
            duration: 1,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.blurEffectView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.3, animations: { [weak self] in
                    self?.resultsVC.view.alpha = 1
                })
           }
        )
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
                
                self.themeNameLabel.isHidden = false
                self.themeNameLabel.textColor = theme.elements
                self.themeNameLabel.text = theme.name
                self.themeNameLabel.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0.5, animations: {
                    self.themeNameLabel.alpha = 0
                }, completion: {_ in
                    self.themeNameLabel.isHidden = true
                })
            }
        )
        timersListVC.setNewTheme(theme)
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
    
    @objc private func alertToAskToStartAgain() {
        let ac = UIAlertController(title: "Your meditation time was saved.", message: "Do you want to start again?", preferredStyle: .actionSheet)

        ac.addAction(UIAlertAction(title: "Start new meditation", style: .default, handler: prepareForNewMeditation))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(ac, animated: true)
    }
    
    @objc private func prepareForNewMeditation(action: UIAlertAction) {
        resultsVC.view.isHidden = true
        blurEffectView.isHidden = true
        doneButton.isHidden = true
        doneButton.isUserInteractionEnabled = true
        resetTime()
    }
    
    private func timing() {
        timer?.tolerance = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                } else {
                    self.minutes = self.minutes + 1
                    ModelTimer.shared.updateCurrentTimeOfTimer(
                        minutes: self.minutes,
                        hours: self.hours
                    )
                }
            } else {
                self.seconds = self.seconds + 1
            }
            self.setTextForTimerLabel()
        }
    }
    
    
}

