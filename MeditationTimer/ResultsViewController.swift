//
//  ResultsViewController.swift
//  MeditationTimer
//
//  Created by Damie on 05.11.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    init(blurStyle: UIBlurEffect.Style) {
        self.blurStyle = blurStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let blurStyle: UIBlurEffect.Style
    
    let days: Int = 17
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        
        label = UILabel()
        label.text = "You're meditating \(days) days in a row"
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    


}
