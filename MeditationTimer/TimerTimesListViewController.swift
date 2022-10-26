//
//  SetTimerSoundViewController.swift
//  MeditationTimer
//
//  Created by Damie on 25.10.2022.
//

import UIKit

class TimerTimesListViewController: UIViewController {

    private var listOfTimerTimes: [String] = []
    
    var timerSign: UIImage!
    var timerSignImageView: UIImageView!
    
    var label: UILabel!
        
    let themeGetter = SetTheme()
    var theme: Theme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        theme = themeGetter.getDefaultTheme()
        
        timerSign = UIImage(systemName: "stopwatch.fill") ?? UIImage(named:"timerSign")
        
        timerSignImageView = UIImageView(image: timerSign)
        timerSignImageView.tintColor = theme.shadow
        timerSignImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerSignImageView)
        
        NSLayoutConstraint.activate([
            timerSignImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerSignImageView.centerYAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = theme.elements
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        setListOfTimerTimes(listOfTimerTimes)
        view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    func setListOfTimerTimes(_ list: [String?]) {
        var timerTextToSet: String = ""
                
        for time in list {
            if let time = time {
                if timerTextToSet != "" {
                    timerTextToSet.append("\n")
                }
                timerTextToSet.append(time)
            }
        }
        
        if timerTextToSet == "" {
            timerTextToSet = "--:--"
        }
        
        self.label.text = timerTextToSet
    }

    func setNewTheme(_ newTheme: Theme) {
        theme = newTheme
        applyNewTheme()
    }
    
    private func applyNewTheme() {
        timerSignImageView.tintColor = theme.shadow
        label.textColor = theme.elements
    }

}
