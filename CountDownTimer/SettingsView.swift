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
    
    @State private var minutes: [Int] = Array(1...60)
    @State private var seconds: [Int] = Array(0...59)
    
    @State private var selectedMinute: Int = 1
    @State private var selectedsecond: Int = 0
    
    @State private var sendEmail: Bool = false
    @State private var selectedColor: Color = .blue
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    List {
                        HStack {
                            Text("Set Game Time:")
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
                        }
                        .font(.title)
                        
                        ColorPicker(selection: $selectedColor) {
                            Text("Pick a color")
                        }
                        
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
                        
                        if game.gameLenght != gameLengthToSet {
                            game.gameLenght = gameLengthToSet
                            game.playerOneTimer?.length = gameLengthToSet
                            game.playerTwoTimer?.length = gameLengthToSet
                            game.resetTimers()
                        }
                        
                        if selectedColor != gameSettings.color {
                            gameSettings.setColor(selectedColor)
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
            selectedColor = gameSettings.color
            selectedMinute = game.gameLenght / 60
            selectedsecond = game.gameLenght % 60
        }
    }
}

#Preview {
    SettingsView(game: Game(gameLenght: 60), gameSettings: ThemeViewModel())
}
