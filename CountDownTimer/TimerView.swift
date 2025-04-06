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
    
    @State private var currentTurn: Turn = .playerOne
    @State private var gameStatus: Status?
                   var passTurnTo: ((Turn, Turn?) -> Void)?
                   var resumeGame: (() -> Status)?
                   var restartGame: (() -> Status)?
                   var pauseGame: (() -> Status)?
    
    @State private var audioPlayer: AVPlayer?
    
    var playerOneTimerDisplay: String
    var playerTwoTimerDisplay: String
    
    init(gameTime: Binding<Int>, showSettings: Binding<Bool>, gameStatus: Status, playerOneTimerDisplay: String, playerTwoTimerDisplay: String, restartGame: (() -> Status)? = nil, resumeGame: (() -> Status)? = nil, pauseGame: (() -> Status)? = nil,  passTurnTo: ((Turn, Turn?) -> Void)? = nil) {
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
        self._gameTime = gameTime
    }
    
    
    var body: some View {
        ZStack {
            // Full screen background
            Color.black
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                // MARK: player 1 side (left side)
                Button {
                    print("(Turn) -> Void")
                    passTurnTo!(.playerOne, .playerTwo)
                    passTurn(to: .playerTwo)
                    tapSound()
                    print("\(currentTurn) turn")
                } label: {
                    Text("\(playerOneTimerDisplay)")
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(color: Color.blue.opacity(0.7), radius: 10)
                        )
                }
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.6)
                .scaleEffect(currentTurn == .playerOne ? 1 : 0.8)
                .disabled(currentTurn != .playerOne || gameStatus == .paused)
                
                // MARK: Controls
                VStack(spacing: 15) {
                    let minutes = (gameTime) / 60
                    let seconds = (gameTime) % 60
                    let gameTimeFormatted = String(format: "%02d : %02d", minutes, seconds)
                    
                    Text("\(gameTimeFormatted)")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.blue)
                        .shadow(color: .black, radius: 5)
                        .padding(.bottom, 10)
                    
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
                    .disabled(gameStatus == .on)
                }
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .padding(.vertical, 20)
                
                // MARK: player 2 side (right side)
                Button {
                    print("(Turn) -> Void")
                    passTurnTo!(.playerTwo, .playerOne)
                    passTurn(to: .playerOne)
                    tapSound()
                    print("\(currentTurn) turn")
                } label: {
                    Text("\(playerTwoTimerDisplay)")
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .shadow(color: Color.blue.opacity(0.7), radius: 10)
                        )
                }.frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.6)
                .scaleEffect(currentTurn == .playerTwo ? 1 : 0.8)
                .disabled(currentTurn != .playerTwo || gameStatus == .paused)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
            print("Sound played")
        } else {
            print("Sound file not found")
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
                .frame(width: 30, height: 30)
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
    @Previewable @State var gameTime = 60
//    TimerView(gameTime: $gameTime, showSettings: $settings, gameStatus: .newGame, playerOneTimerDisplay: "20:20", playerTwoTimerDisplay: "20:20")
    DigitalButton(icon: "play") {
        //
    }
    .frame(width: 70)
}

