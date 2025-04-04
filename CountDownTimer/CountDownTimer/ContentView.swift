//
//  ContentView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 02/04/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var game = Game(gameLenght: 60, playerOneTimer: TimerObject(), playerTwoTimer: TimerObject())
    
    @State private var showSettings: Bool = false
    
    
    var body: some View {
        
        let playerOneTimerDisplay =  String(
            format: "%02d:%02d",
            game.playerOneTimer!.remainingTime / 60, game.playerOneTimer!.remainingTime % 60
        )
        
        let playerTwoTimerDisplay =  String(
            format: "%02d:%02d",
            game.playerTwoTimer!.remainingTime / 60, game.playerTwoTimer!.remainingTime % 60
        )
        
        NavigationStack {
            ZStack {
                Color.black.opacity(0.8)
                
                VStack {
                    TimerView(
                        showSettings: $showSettings,
                        gameStatus: .newGame,
                        playerOneTimerDisplay: playerOneTimerDisplay,
                        playerTwoTimerDisplay: playerTwoTimerDisplay) {
                            game.resetTimers()
                            game.status = .newGame
                            return game.status
                        } resumeGame: {
                            // resume game
                            game.resumeGame()
                            return game.status
                        } pauseGame: {
                            // pauseGame
                            game.pauseGame()
                            return game.status
                        } passTurnTo: { fromPlayer, toPlayer in
                            let timerToStop = game.getPlayerByTurn(playerTurn: fromPlayer)
                            timerToStop.stopTimer()
                            let timerToStart = game.getPlayerByTurn(playerTurn: toPlayer!)
                            timerToStart.startTimer()
                            game.playerTurn = game.getTurnByPlayer(player: timerToStart)
                        }
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showSettings) {
                VStack {
                    Form {
                        Stepper {
                            Text("GAME TIME (in minutes): \(game.gameLenght)")
                        } onIncrement: {
//                            incrementStep()
                            
                            game.gameLenght += 1
                            if game.gameLenght > 60 {
                                game.gameLenght = 1
                            }
                            
                        } onDecrement: {
//                            decrementStep()
                            game.gameLenght -= 1
                            if game.gameLenght < 1 {
                                game.gameLenght = 60
                            }
                        }
                        .padding(5)
                        
                        Button("Set") {
                            game.playerOneTimer?.length = game.gameLenght * 60
                            game.playerTwoTimer?.length = game.gameLenght * 60
                            showSettings.toggle()
                        }
                        
                        Button("Cancel") {
                            showSettings.toggle()
                        }
                    }
                }
            }
        }
    }
}

enum Turn: String  {
    case playerOne = "player one"
    case playerTwo = "player two"
    case none = "none"
}


enum Status {
    case newGame
    case paused
    case on
}


@Observable
class Game {
    
    var gameLenght: Int // in minutes
    
    let playerOneTimer: TimerObject?
    let playerTwoTimer: TimerObject?
    
    var status: Status = .newGame
    var playerTurn: Turn = .none
    
    init(
        gameLenght: Int,
        playerOneTimer: TimerObject? = nil,
        playerTwoTimer: TimerObject? = nil
    ) {
        self.gameLenght = gameLenght
        self.playerOneTimer = playerOneTimer
        self.playerTwoTimer = playerTwoTimer
        playerOneTimer?.length = gameLenght
        playerTwoTimer?.length = gameLenght
    }
    
    func startGame() {
        status = .on
        
    }
    
    func pauseGame() {
        // MARK: onPauseGame
        status = .paused
        playerOneTimer?.stopTimer()
        playerTwoTimer?.stopTimer()
    }
    
    func resumeGame() {
        // MARK: onResumeGame
        status = .on
        let player = getPlayerByTurn(playerTurn: playerTurn)
        player.startTimer()
    }
    
    func resetTimers() {
        status = .newGame
        playerOneTimer?.resetTimer()
        playerTwoTimer?.resetTimer()
        
    }
    
    func getPlayerByTurn(playerTurn: Turn) -> TimerObject {
        switch playerTurn {
        case .playerOne:
            return playerOneTimer!
        case .playerTwo:
            return playerTwoTimer!
        default:
            return TimerObject(length: gameLenght)
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

    

#Preview {
    ContentView()
}
