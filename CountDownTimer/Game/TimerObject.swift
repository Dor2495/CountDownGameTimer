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
    var totalGameLength: Int = 0
    var length: Int?
    var gameStatus: Status = .newGame
    var isTimerRunning: Bool = false
    var timeElapsed = 0
    var timer: Timer? = nil
    
    var remainingTime: Int {
        length! - timeElapsed
    }
    
    init(length: Int? = nil) {
        self.length = 300
    }
    
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
    
    func stopTimer() {
        if isTimerRunning {
            isTimerRunning = false
            timer?.invalidate()
        }
    }
    
    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
    }
    
    // progress = (lenght - timeRemaining) / lenght
    // var progress: CGFloat {
    //     CGFloat(length! - remainingTime) / CGFloat(length!)
    // }
    
    var displayTimeRemaining: String {
        String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
    }
}
