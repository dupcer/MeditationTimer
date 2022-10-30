//
//  SetTimerSoundViewController.swift
//  MeditationTimer
//
//  Created by Damie on 25.10.2022.
//

import UIKit

class MainScreenTimersListViewController: UIViewController, DisplayFormatedTimeExtension {

    var timerSign: UIImage!
    var timerSignImageView: UIImageView!
    
    var label: UILabel!
        
    let themeGetter = SetTheme()
    var theme: Theme? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if theme == nil  {
            theme = themeGetter.getDefaultTheme()
        }
        
        timerSign = UIImage(systemName: "stopwatch") ?? UIImage(named:"timerSign")
        
        timerSignImageView = UIImageView(image: timerSign)
        timerSignImageView.tintColor = theme?.shadow
        timerSignImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerSignImageView)
        
        NSLayoutConstraint.activate([
            timerSignImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerSignImageView.centerYAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 4
        label.textColor = theme?.elements
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        setListOfTimerTimes()
        view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: timerSignImageView.bottomAnchor),
            label.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    func setListOfTimerTimes() {
        var timerTextToSet: String = ""
        
        guard let list = ModelTimer.shared.getListOfTimersForSound() else {
            timerTextToSet = "--:-- min"
            return self.label.text = timerTextToSet
        }
        
        for time in list {
            timerTextToSet.append(getShortedFormattedTimer(time))
            timerTextToSet.append("\n")
        }
        return self.label.text = timerTextToSet
    }

    func setNewTheme(_ newTheme: Theme) {
        theme = newTheme
        applyNewTheme()
    }
    
    private func applyNewTheme() {
        timerSignImageView.tintColor = theme?.shadow
        label.textColor = theme?.elements
    }

    
}
