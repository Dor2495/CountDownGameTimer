//
//  Game.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import Foundation

@Observable
class Game {
    
    var gameLength: Int // in minutes
    
    let playerOneTimer: TimerObject
    let playerTwoTimer: TimerObject
    
    var status: Status = .newGame
    var playerTurn: Turn = .playerOne
    
    init(
        gameLength: Int,
        playerOneTimer: TimerObject? = nil,
        playerTwoTimer: TimerObject? = nil
    ) {
        self.gameLength = gameLength
        self.playerOneTimer = playerOneTimer ?? TimerObject(length: gameLength)
        self.playerTwoTimer = playerTwoTimer ?? TimerObject(length: gameLength)
    }
    
    func startGame() {
        status = .on
    }
    
    func pauseGame() {
        // MARK: onPauseGame
        status = .paused
        playerOneTimer.stopTimer()
        playerTwoTimer.stopTimer()
    }
    
    func resumeGame() {
        // MARK: onResumeGame
        status = .on
        let player = getPlayerByTurn(playerTurn: playerTurn)
        player.startTimer()
    }
    
    func resetTimers() {
        status = .newGame
        playerOneTimer.resetTimer()
        playerTwoTimer.resetTimer()
    }
    
    func getPlayerByTurn(playerTurn: Turn) -> TimerObject {
        switch playerTurn {
        case .playerOne:
            return playerOneTimer
        case .playerTwo:
            return playerTwoTimer
        default:
            return TimerObject(length: gameLength)
        }
    }
    
    func getTurnByPlayer(player: TimerObject) -> Turn {
        if player === playerOneTimer {
            return .playerOne
        } else {
            return .playerTwo
        }
    }
}
