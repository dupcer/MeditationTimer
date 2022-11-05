//
//  ResultsViewController.swift
//  MeditationTimer
//
//  Created by Damie on 05.11.2022.
//

import UIKit

class ResultsViewController: UIViewController {

    let days: Int = 17
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        
        label = UILabel()
        label.text = "You're meditating \(days) in a row"
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    


}
