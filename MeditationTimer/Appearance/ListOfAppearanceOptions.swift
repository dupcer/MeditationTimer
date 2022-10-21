//
//  ListOfAppearanceOptions.swift
//  MeditationTimer
//
//  Created by Damie on 21.10.2022.
//

import Foundation
import QuartzCore
import UIKit

struct ListOfAppearanceOptions {
    
    let blackAndBlue: [UIColor] = [.black, .blue, .black]
    
}

extension CAGradientLayer {
    static func gradientLayer(for colors: [CGColor], in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors
        layer.frame = frame
        return layer
    }
}
