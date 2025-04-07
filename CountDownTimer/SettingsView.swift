//
//  SettingsView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    var game: Game
    var gameSettings: ThemeViewModel
    
    @State private var minutes: [Int] = Array(0...60)
    @State private var seconds: [Int] = Array(0...59)
    
    @State private var selectedMinute: Int = 1
    @State private var selectedsecond: Int = 0
    
    @State private var playerOneTimeColor: Color = .blue
    @State private var playerTwoTimeColor: Color = .blue
    
    @State private var gameTimeColor: Color = .blue
    
    @State private var buttonsColor: Color = .blue
    
    
    @State private var sendEmail: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    List {
                        // MARK: Time Set
                        Section {
                            HStack {
                                Spacer()
                                Picker(selection: $selectedMinute) {
                                    ForEach(minutes, id: \.hashValue) { minute in
                                        Text("\(minute)").tag(minute)
                                    }
                                } label: {
                                    Text("Pick a minute")
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 70, height: 100)
                                
                                Text(":")
                                    .padding()
                                    
                                Picker(selection: $selectedsecond) {
                                    ForEach(seconds, id: \.hashValue) { second in
                                        Text("\(second)").tag(second)
                                    }
                                } label: {
                                    Text("Select seconds")
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 70, height: 100)
                                Spacer()
                            }
                        } header: {
                            Text("Set Game Time:")
                        }
                        .font(.title)
                        
                        // MARK: Colors set
                        Section {
                            if gameSettings.expendColorSettings {
                                ColorPicker(selection: $playerOneTimeColor) {
                                    Text("Player One color")
                                }
                                
                                ColorPicker(selection: $playerTwoTimeColor) {
                                    Text("Player Two color")
                                }
                                
                                ColorPicker(selection: $gameTimeColor) {
                                    Text("Game Time color")
                                }
                                
                                ColorPicker(selection: $buttonsColor) {
                                    Text("Buttons color")
                                }
                            }
                        } header: {
                            HStack {
                                Text("Colors")
                                    .font(.title)
                                Spacer()
                                Image(systemName: "arrow.down")
                                    .rotationEffect(gameSettings.expendColorSettings ? .degrees(-180) : .degrees(0))
                                    .onTapGesture {
                                        withAnimation(.default) {
                                            gameSettings.expendColorSettings.toggle()
                                        }
                                    }
                            }
                        }
                        
                        
                        // MARK: Email
                        Button("Send feedback") {
                            sendEmail = true
                        }
                        .foregroundColor(.blue)
                    }
                    .scrollContentBackground(.hidden)
                }
                .foregroundColor(.white)
            }
            .navigationTitle("Game Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let gameLengthToSet = (selectedMinute * 60) + selectedsecond
                        
                        if game.gameLength != gameLengthToSet {
                            game.gameLength = gameLengthToSet
                            game.playerOneTimer.length = gameLengthToSet
                            game.playerTwoTimer.length = gameLengthToSet
                            game.resetTimers()
                        }
                        
                        if gameSettings.playerOneTimeColor != playerOneTimeColor {
                            gameSettings.setPlayerOneTimeColor(playerOneTimeColor)
                        }
                        
                        if gameSettings.playerTwoTimeColor != playerTwoTimeColor {
                            gameSettings.setPlayerTwoTimeColor(playerTwoTimeColor)
                        }
                        
                        if gameSettings.gameTimeColor != gameTimeColor {
                            gameSettings.setGameTimeColor(gameTimeColor)
                        }
                        
                        if gameSettings.buttonsColor != buttonsColor {
                            gameSettings.setButtonsColor(buttonsColor)
                        }
                            
                        
                        dismiss()
                    }
                }
            }
            .font(.title3)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $sendEmail) {
            SendEmailView()
        }
        .onAppear {
            playerOneTimeColor = gameSettings.playerOneTimeColor
            playerTwoTimeColor = gameSettings.playerTwoTimeColor
            buttonsColor = gameSettings.buttonsColor
            gameTimeColor = gameSettings.gameTimeColor
            
            selectedMinute = game.gameLength / 60
            selectedsecond = game.gameLength % 60
        }
    }
}

#Preview {
    SettingsView(game: Game(gameLength: 60), gameSettings: ThemeViewModel())
}
