//
//  GameSettingsViewModel.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import Foundation
import SwiftUI

@Observable
class ThemeViewModel {
    
    var playerOneTimeColor: Color = .blue
    var playerTwoTimeColor: Color = .blue
    var buttonsColor: Color = .blue
    var gameTimeColor: Color = .blue
    
    var expendColorSettings: Bool
    
    init(
        playerOneTimeColor: Color = .blue,
        playerTwoTimeColor: Color = .blue,
        buttonsColor: Color = .white,
        gameTimeColor: Color = .white,
        expendColorSettings: Bool = true
    ) {
        self.playerOneTimeColor = playerOneTimeColor
        self.playerTwoTimeColor = playerTwoTimeColor
        self.buttonsColor = buttonsColor
        self.gameTimeColor = gameTimeColor
        self.expendColorSettings = expendColorSettings
    }
    
    func setPlayerOneTimeColor(_ color: Color) {
        self.playerOneTimeColor = color
    }
    
    func setPlayerTwoTimeColor(_ color: Color) {
        self.playerTwoTimeColor = color
    }
    
    func setButtonsColor(_ color: Color) {
        self.buttonsColor = color
    }
    
    func setGameTimeColor(_ color: Color) {
        self.gameTimeColor = color
    }
}
