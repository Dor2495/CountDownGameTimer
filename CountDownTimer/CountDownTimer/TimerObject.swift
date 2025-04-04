//
//  ViewModel.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 03/04/2025.
//

import Foundation
import SwiftUI

@Observable
class TimerObject {
    // specify color?
    var color: Color?
    
    var totalGameLength: Int = 0
    // lenght
    var length: Int?
    
    // init
    init(color: Color? = nil, length: Int? = nil) {
        self.color = color
        self.length = 300
    }
    var gameStatus: Status = .newGame
    
    var isTimerRunning: Bool = false
    
    // timeElapsed - how match time timer counted
    var timeElapsed = 0
    
    // time remaining = lengh - timeElapsed
    var remainingTime: Int {
        length! - timeElapsed
    }
    
    // Timer instance?
    var timer: Timer? = nil
    // user the timer to set intervals and increase timeElapsed
    
    
    // startTimer
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[self] _ in
            if remainingTime > 0 {
                timeElapsed += 1
            } else {
                stopTimer()
            }
        }
    }
    
    // stopTimer
    func stopTimer() {
        if isTimerRunning {
            isTimerRunning = false
            timer?.invalidate()
        }
    }
    
    // resetTimer
    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
    }
    
    // progress = (lenght - timeRemaining) / lenght
    // var progress: CGFloat {
    //     CGFloat(length! - remainingTime) / CGFloat(length!)
    // }
    
    // var playButtonDisabled: Bool {
    //     guard remainingTime > 0, !isTimerRunning else { return true}
    //     return false
    // }
    
    // var pauseButtonDisabled: Bool {
    //     guard remainingTime > 0, isTimerRunning else { return true }
    //     return false
    // }
    
    // var resetButtonDisabled: Bool {
    //     guard remainingTime != length, !isTimerRunning else { return true }
    //     return false
    // }
    
    var displayTimeRemaining: String {
        return String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
    }
}
