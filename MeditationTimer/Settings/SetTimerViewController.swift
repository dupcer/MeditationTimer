//
//  SetTimerViewController.swift
//  MeditationTimer
//
//  Created by Damie on 27.10.2022.
//

import UIKit

class SetTimerViewController: UIViewController {

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

        switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isUserInteractionEnabled = true
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

}
