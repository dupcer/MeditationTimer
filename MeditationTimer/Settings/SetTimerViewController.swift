//
//  SetTimerViewController.swift
//  MeditationTimer
//
//  Created by Damie on 27.10.2022.
//

import UIKit

class SetTimerViewController: UIViewController {

    let modelTimer: ModelTimer
    let indexOfCellToSetTimerFor: Int
    private var modelTimerThatWasSetBefore: TimerForSound? {
        return modelTimer.getListOfTimersForSound()?[indexOfCellToSetTimerFor] ?? nil
    }
    
    init(modelTimer: ModelTimer, indexOfCellToSetTimerFor: Int) {
        self.modelTimer = modelTimer
        self.indexOfCellToSetTimerFor = indexOfCellToSetTimerFor
        super.init(nibName: nil, bundle: nil)
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
    
    private var timePicker: UIDatePicker!
    
    private let constant: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .secondarySystemBackground
        switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isUserInteractionEnabled = true
        if modelTimerThatWasSetBefore != nil {
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
        if isSwitchOn {
            if let model = modelTimerThatWasSetBefore {
                let seconds: Double = Double( ((model.hour * 60) + model.minute) * 60 )
                timePicker.countDownDuration = seconds

            }
        }
        
        view.addSubview(timePicker)
        
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        setSwitchToBeOn(sender.isOn)
    }
    
    func setSwitchToBeOn(_ newValue: Bool) {
        self.isSwitchOn = newValue
        switchButton.isOn = newValue
        timePicker.isHidden = !newValue
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if !isSwitchOn {
            return
        }
        
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let timerForSound = TimerForSound(hour: UInt(components.hour ?? 0), minute: UInt(components.minute ?? 1))
        
        modelTimer.addNewTimerToList(timerForSound, indexPathItem: indexOfCellToSetTimerFor)
    }
    
    
    
}
