//
//  TimerView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 02/04/2025.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    @Binding var gameTime: Int
    @Binding var showSettings: Bool
    @Binding private var gameStatus: Status
    var colorTheme: Color
    
    @State private var currentTurn: Turn = .playerOne
    var passTurnTo: ((Turn, Turn?) -> Void)?
    var resumeGame: (() -> Status)?
    var restartGame: (() -> Status)?
    var pauseGame: (() -> Status)?
    
    @State private var audioPlayer: AVPlayer?
    
    var playerOneTimerDisplay: String
    var playerTwoTimerDisplay: String
    
    init(gameTime: Binding<Int>, showSettings: Binding<Bool>, colorTheme: Color = .blue, gameStatus: Binding<Status>, playerOneTimerDisplay: String, playerTwoTimerDisplay: String, restartGame: (() -> Status)? = nil, resumeGame: (() -> Status)? = nil, pauseGame: (() -> Status)? = nil, passTurnTo: ((Turn, Turn?) -> Void)? = nil) {
        self.colorTheme = colorTheme
        self._gameStatus = gameStatus
        self.playerOneTimerDisplay = playerOneTimerDisplay
        self.playerTwoTimerDisplay = playerTwoTimerDisplay
        self.pauseGame = pauseGame
        self.restartGame = restartGame
        self.passTurnTo = passTurnTo
        self.currentTurn = .playerOne
        self.resumeGame = resumeGame
        self._showSettings = showSettings
        self._gameTime = gameTime
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    // Dynamically calculate width to ensure proper fitting
                    let availableWidth = geometry.size.width
                    let playerButtonWidth = availableWidth * 0.38 // Slightly reduced from 0.4
                    let controlsWidth = availableWidth * 0.22 // Slightly increased from 0.2
                    let buttonHeight = min(geometry.size.height * 0.6, geometry.size.width * 0.7)
                    
                    // Player 1 Timer Button
                    PlayerTimerButton(
                        display: playerOneTimerDisplay,
                        color: colorTheme,
                        isActive: currentTurn == .playerOne,
                        isDisabled: currentTurn != .playerOne || gameStatus == .paused
                    ) {
                        tapSound()
                        passTurnTo!(.playerOne, .playerTwo)
                        passTurn(to: .playerTwo)
                        if playerOneTimerDisplay == "00:00" {
                            gameStatus = .newGame
                        }
                        
                    }
                    .frame(width: playerButtonWidth, height: buttonHeight)
                    
                    Spacer(minLength: 2)
                    
                    // Controls Section
                    VStack(spacing: geometry.size.height * 0.04) {
                        let minutes = (gameTime) / 60
                        let seconds = (gameTime) % 60
                        let gameTimeFormatted = String(format: "%02d : %02d", minutes, seconds)
                        
                        Text("\(gameTimeFormatted)")
                            .font(.system(size: min(geometry.size.width * 0.05, 30)))
                            .bold()
                            .foregroundColor(colorTheme)
                            .shadow(color: .black, radius: 5)
                            .padding(.bottom, geometry.size.height * 0.02)
                        
                        ControlButton(
                            icon: gameStatus == .paused ? "forward.fill" : "play.fill",
                            size: min(controlsWidth * 0.3, 30),
                            color: colorTheme
                        ) {
                            gameStatus = resumeGame!()
                        }
                        .disabled(gameStatus == .on)
                        
                        ControlButton(
                            icon: "arrow.clockwise",
                            size: min(controlsWidth * 0.3, 30),
                            color: colorTheme
                        ) {
                            gameStatus = restartGame!()
                        }
                        .disabled(gameStatus == .newGame || gameStatus == .on)
                        
                        ControlButton(
                            icon: "pause.fill",
                            size: min(controlsWidth * 0.3, 30),
                            color: colorTheme
                        ) {
                            gameStatus = pauseGame!()
                        }
                        .disabled(gameStatus == .paused || gameStatus == .newGame)
                        
                        ControlButton(
                            icon: "gear",
                            size: min(controlsWidth * 0.3, 30),
                            color: colorTheme
                        ) {
                            showSettings = true
                        }
                        .disabled(gameStatus == .on)
                    }
                    .frame(width: controlsWidth)
                    .padding(.vertical, geometry.size.height * 0.05)
                    
                    Spacer(minLength: 2)
                    
                    // Player 2 Timer Button
                    PlayerTimerButton(
                        display: playerTwoTimerDisplay,
                        color: colorTheme,
                        isActive: currentTurn == .playerTwo,
                        isDisabled: currentTurn != .playerTwo || gameStatus == .paused
                    ) {
                        tapSound()
                        passTurnTo!(.playerTwo, .playerOne)
                        passTurn(to: .playerOne)
                        if playerTwoTimerDisplay == "00:00" {
                            gameStatus = .newGame
                        }
                    }
                    .frame(width: playerButtonWidth, height: buttonHeight)
                }
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    func passTurn(to turn: Turn) {
        withAnimation(.linear(duration: 0.3)) {
            currentTurn = turn
        }
    }
    
    func tapSound() {
        if let path = Bundle.main.path(forResource: "button_sound", ofType: "mov") {
            let url = URL(fileURLWithPath: path)
            audioPlayer = AVPlayer(url: url)
            audioPlayer?.play()
        }
    }
}

#Preview {
    @Previewable @State var status = Status.newGame
    TimerView(
        gameTime: .constant(60),
        showSettings: .constant(false),
        gameStatus: $status,
        playerOneTimerDisplay: "20:20",
        playerTwoTimerDisplay: "20:20"
    )
}

