//
//  ContentView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 02/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var gameSettings = ThemeViewModel()
    @State private var game = Game(
        gameLength: 60,
        playerOneTimer: TimerObject(),
        playerTwoTimer: TimerObject()
    )
    @State private var showSettings: Bool = false
    
    var playerOneTimerDisplay: String {
        game.playerOneTimer.displayTimeRemaining
    }
    
    var playerTwoTimerDisplay: String {
        game.playerTwoTimer.displayTimeRemaining
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.8)
                
                VStack {
                    TimerView(
                        gameTime: $game.gameLength,
                        showSettings: $showSettings,
                        gameSettings: gameSettings,
                        gameStatus: $game.status,
                        playerOneTimerDisplay: playerOneTimerDisplay,
                        playerTwoTimerDisplay: playerTwoTimerDisplay
                    ) {
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
                            if game.status != .newGame {
                                timerToStart.startTimer()
                            }
                            game.playerTurn = game.getTurnByPlayer(player: timerToStart)
                        }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(game: game, gameSettings: gameSettings)
            }
        }
    }
} 

#Preview {
    ContentView()
}
