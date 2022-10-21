//
//  AppearanceEditViewController.swift
//  MeditationTimer
//
//  Created by Damie on 21.10.2022.
//

import UIKit

class AppearanceEditViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshBackground()
    }
    
    func refreshBackground() {
        let vc: ViewController? = ViewController()
        vc?.setBackground(colors: [.blue, .black, .green])
    }

}
