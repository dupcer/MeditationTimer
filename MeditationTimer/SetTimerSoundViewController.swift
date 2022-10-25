//
//  SetTimerSoundViewController.swift
//  MeditationTimer
//
//  Created by Damie on 25.10.2022.
//

import UIKit

class SetTimerSoundViewController: UIViewController {

    var btn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn = UILabel()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.text = "Azazaz"
        btn.textAlignment = .center
        btn.textColor = .green
        btn.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        
        view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        self.view.backgroundColor = .purple
    }
    



}
