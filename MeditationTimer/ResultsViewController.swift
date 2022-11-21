//
//  ResultsViewController.swift
//  MeditationTimer
//
//  Created by Damie on 05.11.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private let model = ModelTrackUserResults.shared
    
    init(blurStyle: UIBlurEffect.Style) {
        self.blurStyle = blurStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let blurStyle: UIBlurEffect.Style
    
    private var days: Int {
        model.numberOfConsecutiveDays
    }
    
    private var aboveText: UILabel!
    private var numberImage: UIImage!
    private var belowText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        
        aboveText = UILabel()
        numberImage = UIImage()
        belowText = UILabel()
        
        populateProgressText()
        
        aboveText.lineBreakMode = .byWordWrapping
        view.addSubview(aboveText)
        aboveText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aboveText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboveText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private func populateProgressText() {
        switch days {
        case ...1:
            aboveText.text = "It's"
            numberImage = UIImage(systemName: "1.square.fill")
            belowText.text = "day that you're consecutively meditating"
        case 50...:
            aboveText.text = "You're consecutively meditating for over"
            numberImage = UIImage(systemName: "50.square.fill")
            belowText.text = "days now"
        default:
            aboveText.text = "You're consecutively meditating for "
            numberImage = UIImage(systemName: "\(days).square.fill")
            aboveText.text = "days"
        }
    }

}
