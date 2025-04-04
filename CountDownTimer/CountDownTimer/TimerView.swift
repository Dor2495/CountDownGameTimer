//
//  TimerView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 02/04/2025.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var showSettings: Bool
    
    @State private var currentTurn: Turn = .playerOne
    @State private var gameStatus: Status?
                   var passTurnTo: ((Turn, Turn?) -> Void)?
                   var resumeGame: (() -> Status)?
                   var restartGame: (() -> Status)?
                   var pauseGame: (() -> Status)?
    
    init(showSettings: Binding<Bool>, gameStatus: Status, playerOneTimerDisplay: String, playerTwoTimerDisplay: String, restartGame: (() -> Status)? = nil, resumeGame: (() -> Status)? = nil, pauseGame: (() -> Status)? = nil,  passTurnTo: ((Turn, Turn?) -> Void)? = nil) {
        print("init")
        self.gameStatus = gameStatus
        self.playerOneTimerDisplay = playerOneTimerDisplay
        self.playerTwoTimerDisplay = playerTwoTimerDisplay
        self.pauseGame = pauseGame
        self.restartGame = restartGame
        self.passTurnTo = passTurnTo
        self.currentTurn = .playerOne
        self.resumeGame = resumeGame
        self._showSettings = showSettings
    }
    
    
    var playerOneTimerDisplay: String
    var playerTwoTimerDisplay: String
    
    var body: some View {
        GeometryReader { proxy in
                
            HStack {
                // MARK: player 1 side (left side)
                VStack {
                    Button {
                        print("(Turn) -> Void")
                        //                        withAnimation(.linear(duration: 0.3)) {
                        passTurnTo!(.playerOne, .playerTwo)
                        passTurn(to: .playerTwo)
                        //                        }
                        print("\(currentTurn) turn")
                    } label: {
                        Text("\(playerOneTimerDisplay)")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.blue)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .shadow(color: Color.blue.opacity(0.7), radius: 10)
                                    .frame(height: proxy.size.height * 0.45)
                            )
                    }
                    .scaleEffect(currentTurn == .playerOne ? 2 : 0.68)
                    .disabled(currentTurn != .playerOne || gameStatus == .paused || gameStatus == .newGame)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // MARK: Controls
                VStack(spacing: 30) {
                    DigitalButton(icon: gameStatus == .paused ? "forward.fill" : "play.fill") {
                        print("(Turn) -> Void")
                        print("Start pressed")
                        gameStatus = resumeGame!()
                    }
                    .disabled(gameStatus == .on)
                    
                    DigitalButton(icon: "arrow.clockwise") {
                        print("(Turn) -> Void")
                        print("Restart pressed")
                        gameStatus = restartGame!()
                    }
                    .disabled(gameStatus == .newGame || gameStatus == .on)
                    
                    DigitalButton(icon: "pause.fill") {
                        print("() -> Void")
                        print("Pause pressed")
                        gameStatus = pauseGame!()
                    }
                    .disabled(gameStatus == .paused || gameStatus == .newGame)
                    
                    DigitalButton(icon: "gear") {
                        showSettings = true
                    }
                }
                
                // MARK: player 2 side (right side)
                VStack {
                    VStack {
                        Button {
                            print("(Turn) -> Void")
                            //                            withAnimation(.linear(duration: 0.3)) {
                            passTurnTo!(.playerTwo, .playerOne)
                            passTurn(to: .playerOne)
                            //                            }
                            print("\(currentTurn) turn")
                            
                        } label: {
                            Text("\(playerTwoTimerDisplay)")
                                .font(.system(size: 40, weight: .bold, design: .monospaced))
                                .foregroundColor(Color.blue)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black)
                                        .shadow(color: Color.blue.opacity(0.7), radius: 10)
                                        .frame(height: proxy.size.height * 0.45)
                                )
                        }
                        .scaleEffect(currentTurn == .playerTwo ? 2 : 0.8)
                        .disabled(currentTurn != .playerTwo || gameStatus == .paused || gameStatus == .newGame)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    func passTurn(to turn: Turn) {
        withAnimation(.linear(duration: 0.3)) {
            currentTurn = turn
        }
    }
}

struct DigitalButton: View {
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.blue)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .shadow(color: Color.blue.opacity(0.7), radius: 10)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    @Previewable @State var settings = false
    TimerView(showSettings: $settings, gameStatus: .newGame, playerOneTimerDisplay: "20:20", playerTwoTimerDisplay: "20:20")
    
}

