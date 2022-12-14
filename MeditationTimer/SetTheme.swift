//
//  Theme.swift
//  MeditationTimer
//
//  Created by Damie on 24.10.2022.
//

import UIKit


class SetTheme: UIView {
    let userDefaults = UserDefaults.standard
    
    private let listOfThemes: [Theme] = [defaultTheme, starryNightTheme, blackRedTheme, blackTheme, boldBlackTheme, whiteTheme]
    
//    private var lastUsedThemeIndex: Int {
//        get {
//            userDefaults.integer(forKey: "lastUsedThemeIndex")
//        } set {
//            userDefaults.set(newValue, forKey: "lastUsedThemeIndex")
//        }
//    }
    
    private var currentThemeIndex:Int {
        get {
            userDefaults.integer(forKey: "lastUsedThemeIndex")
        } set {
            userDefaults.set(newValue, forKey: "lastUsedThemeIndex")
        }
    }
    
    func getCurrentTheme() -> Theme {
        return listOfThemes[currentThemeIndex]
    }
    
    func getDimDownTheme() -> Theme {
        return dimDownTheme
    }
    
    func getNewTheme(next: Bool) -> Theme? {
        if next, listOfThemes.count > currentThemeIndex+1 {
            currentThemeIndex += 1
            return listOfThemes[currentThemeIndex]
        } else if !next, (currentThemeIndex-1) >= 0 {
            currentThemeIndex -= 1
            return listOfThemes[currentThemeIndex]
        }
        return nil
    }

}

fileprivate let ofSize: CGFloat = 62
struct Theme {
    
    let name: String
    let background: UIColor
    let shadow: UIColor
    let elements: UIColor
    var buttonConfig: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemGray, .systemGray3]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)) {
        willSet {
            self.buttonConfig = newValue
        }
    }
    var font: UIFont = UIFont.systemFont(ofSize: ofSize, weight: .ultraLight) {
        willSet {
            self.font = newValue
        }
    }
}



fileprivate let defaultTheme = Theme(name: "System", background: .systemBackground, shadow: .systemGray, elements: .systemGray)

fileprivate let blackTheme = Theme(name: "Black", background: UIColor.black, shadow: .systemGray, elements: .systemGray, buttonConfig: UIImage.SymbolConfiguration(paletteColors: [.darkGray]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)))

fileprivate let blackRedTheme = Theme(name: "Red & Black", background: UIColor.black, shadow: .systemPink, elements: .red, buttonConfig: UIImage.SymbolConfiguration(paletteColors: [.red,  #colorLiteral(red: 0.66165483, green: 0.1116623357, blue: 0.03887774795, alpha: 1)]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)))

fileprivate let whiteTheme = Theme(name: "White", background: UIColor.white, shadow: .systemGray, elements: .black, buttonConfig: UIImage.SymbolConfiguration(paletteColors: [.black, .systemGray]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)))

fileprivate let starryNightTheme = Theme(name: "Starry Night", background: #colorLiteral(red: 0.0698717013, green: 0.02795249037, blue: 0.2497010231, alpha: 1), shadow: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), elements: #colorLiteral(red: 0.6386947632, green: 0.5740429759, blue: 0.9906172156, alpha: 1), buttonConfig: UIImage.SymbolConfiguration(paletteColors:  [ #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)))

fileprivate let boldBlackTheme = Theme(name: "Grey", background: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), shadow: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), elements: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1),  buttonConfig: UIImage.SymbolConfiguration(paletteColors:  [ #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .light)), font: UIFont.systemFont(ofSize: ofSize, weight: .regular))

fileprivate let dimDownTheme = Theme(name: "dimDown SPECIALTHEME", background: .black, shadow: .clear, elements: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), buttonConfig: UIImage.SymbolConfiguration(paletteColors: [ #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1),  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]).applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 100))).applying(UIImage.SymbolConfiguration(weight: .ultraLight)))
