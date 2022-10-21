//
//  Animations.swift
//  MeditationTimer
//
//  Created by Damie on 21.10.2022.
//

import UIKit

class Animations: UIView {

    func trasition(with view: UIView) {
        UIView.transition(with: view,
                          duration: 3,
                          options: [.transitionFlipFromBottom],
                          animations: {
                        
                    }
        )
    }

}
