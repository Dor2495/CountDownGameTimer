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
    
    var color: Color = .blue
    
    init(color: Color = .blue) {
        self.color = color
    }
    
    func setColor(_ color: Color) {
        self.color = color
    }
    
}
