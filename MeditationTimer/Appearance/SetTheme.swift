//
//  Theme.swift
//  MeditationTimer
//
//  Created by Damie on 24.10.2022.
//

import UIKit


class SetTheme: UIView {

    private let listOfThemes: [Theme] = [blackTheme, nightTheme, whiteTheme]
    
    private let lastUsedThemeIndex = 0
    private var currentThemeIndex = 0
    
    func getDefaultTheme() -> Theme {
        return listOfThemes[lastUsedThemeIndex]
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

struct Theme {
    let background: UIColor
    let shadow: UIColor
    let elements: UIColor
    let buttonConfigColors: [UIColor]
//    var buttonConfigs: UIImage.SymbolConfiguration? = nil
}



fileprivate let defaultTheme = Theme(background: .systemBackground, shadow: .systemGray, elements: .systemGray, buttonConfigColors: [.systemGray, .systemGray3])

fileprivate let blackTheme = Theme(background: .systemBackground, shadow: .systemGray, elements: .systemGray, buttonConfigColors: [.systemGray, .systemGray3])

fileprivate let nightTheme = Theme(background: UIColor.black, shadow: .systemGray, elements: .red, buttonConfigColors: [.systemPink, .red]
)

fileprivate let whiteTheme = Theme(background: UIColor.white, shadow: .systemGray, elements: .black, buttonConfigColors: [.black, .systemGray])
