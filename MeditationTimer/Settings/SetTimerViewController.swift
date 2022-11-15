//
//  SetTimerViewController.swift
//  MeditationTimer
//
//  Created by Damie on 27.10.2022.
//

import UIKit

class SetTimerViewController: UIViewController {
    
    init(id: String,
         isTimerFreshNew: Bool,
         mainScreenTimersListVC: MainScreenTimersListViewController?) {
        self.modelID = id
        self.isTimerFreshNew = isTimerFreshNew
        self.mainScreenTimersListVC = mainScreenTimersListVC
        super.init(nibName: nil, bundle: nil)
    }
    
    let mainScreenTimersListVC: MainScreenTimersListViewController?
    let modelID: String
    let isTimerFreshNew: Bool
    
    let modelTimer = ModelTimer.shared
    var currentSoundFileName: String? {
        guard let timer = modelTimer.getTimerForSound(with: modelID) else {
            return nil
        }
        return timer.soundFileName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var switchButton: UISwitch!
    var isSwitchOn: Bool = false
    
    private var mainTextLabel: UILabel!
    private let mainText = "Set timer"
    private var secondaryTextLabel: UILabel!
    private let secondaryText = "Turn the timer on, to hear sound on the set time"
    private let soundButtonTitle = "Sound for this timer"
    
    private var soundSubtitle: String {
        return ModelSound.shared.getDescriptiveName(currentSoundFileName)
    }
    
    private var timePicker: UIDatePicker!
    
    private var soundButton: UIButton!
    
    private let constant: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .secondarySystemBackground
        switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isUserInteractionEnabled = true
        if !isTimerFreshNew {
            isSwitchOn = true
        }
        switchButton.isOn = isSwitchOn
        switchButton.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)

        view.addSubview(switchButton)
        
        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            switchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
        ])
        
        mainTextLabel = UILabel()
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.text = mainText
        mainTextLabel.textAlignment = .natural
        mainTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(mainTextLabel)
        NSLayoutConstraint.activate([
            mainTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            mainTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
        ])
        
        secondaryTextLabel = UILabel()
        secondaryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryTextLabel.text = secondaryText
        secondaryTextLabel.textAlignment = .natural
        secondaryTextLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.addSubview(secondaryTextLabel)
        NSLayoutConstraint.activate([
            secondaryTextLabel.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: constant/2),
            secondaryTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
        ])
        
        timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        isSwitchOn ? (timePicker.isHidden = false) : (timePicker.isHidden = true)
        timePicker.datePickerMode = .countDownTimer
        if isSwitchOn, let model = modelTimer.getTimerForSound(with: modelID) {
            timePicker.countDownDuration = model.totalAmountOfSeconds
        }
        view.addSubview(timePicker)
        
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        

        
        soundButton = UIButton(configuration: getSoundButtonConfig(), primaryAction: nil)
        soundButton.addTarget(self, action: #selector(selectSoundButtonTapped), for: .touchUpInside)
        isSwitchOn ? (soundButton.isHidden = false) : (soundButton.isHidden = true)
        

        soundButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soundButton)
        
        NSLayoutConstraint.activate([
            soundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -constant),
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        soundButton.configuration = getSoundButtonConfig()
    }
    
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        setSwitchToBeOn(sender.isOn)
    }
    
    func setSwitchToBeOn(_ newValue: Bool) {
        self.isSwitchOn = newValue
        switchButton.isOn = newValue
        timePicker.isHidden = !newValue
        soundButton.isHidden = !newValue
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if !isSwitchOn {
            return modelTimer.removeTimerFromList(with: modelID)
        }
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let noActualTimeSet: Bool = components.hour == 0 && components.minute == 0
        var min: UInt = 1
        if let compMin = components.minute, !noActualTimeSet {
            min = UInt(compMin)
        }
        
        modelTimer.setTimeForTimer(
            withId: modelID,
            hour: UInt(components.hour ?? 0),
            minute: min)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
        if let vcToUpdate = mainScreenTimersListVC {
            vcToUpdate.setListOfTimerTimes()
        }
    }

    @objc private func selectSoundButtonTapped() {
        let setSoundVC = SetSoundTableViewController(id: modelID)
        _ = UINavigationController(rootViewController: setSoundVC)
        navigationController?.pushViewController(setSoundVC, animated: true)
    }
     
    private func getSoundButtonConfig() -> UIButton.Configuration {
        var soundButtonConfig = UIButton.Configuration.gray()
        soundButtonConfig.title = soundButtonTitle
        soundButtonConfig.subtitle = soundSubtitle
        soundButtonConfig.image = UIImage(systemName: "speaker.wave.3.fill") ?? UIImage(named:"arrowSign")
        
        soundButtonConfig.titleAlignment = .leading
        soundButtonConfig.buttonSize = .large
        soundButtonConfig.baseForegroundColor = .label
        soundButtonConfig.cornerStyle = .large
        soundButtonConfig.imagePlacement = .trailing
        soundButtonConfig.imagePadding = view.frame.width / 3
        return soundButtonConfig
    }
    
}
