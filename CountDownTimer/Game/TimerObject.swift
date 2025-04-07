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
    var length: Int
    var gameStatus: Status = .newGame
    var isTimerRunning: Bool = false
    var timeElapsed = 0
    var timer: Timer? = nil
    
    var remainingTime: Int {
        length - timeElapsed
    }
    
    init(length: Int = 300) {
        self.length = length
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.timeElapsed += 1
            } else {
                self.stopTimer()
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        if isTimerRunning {
            isTimerRunning = false
            timer?.invalidate()
            timer = nil
        }
    }
    
    func resetTimer() {
        stopTimer()
        timeElapsed = 0
    }
    
    // progress = (lenght - timeRemaining) / lenght
    // var progress: CGFloat {
    //     CGFloat(length! - remainingTime) / CGFloat(length!)
    // }
    
    var displayTimeRemaining: String {
        String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60)
    }
}
