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
    
    @State private var minutes: [Int] = Array(1...60)
    @State private var seconds: [Int] = Array(0...59)
    
    @State private var selectedMinute: Int = 1
    @State private var selectedsecond: Int = 0
    
    @State private var sendEmail: Bool = false
    
    var body: some View {
        NavigationStack {
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
                    
                    Button("Set") {
                        let gameLengthToSet = (selectedMinute * 60) + selectedsecond
                        game.gameLenght = gameLengthToSet
                        game.playerOneTimer?.length = gameLengthToSet
                        game.playerTwoTimer?.length = gameLengthToSet
                        game.resetTimers()
                        
                        dismiss()
                    }
                    
                    Button("Send feedback") {
                        sendEmail = true
                    }
                    
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
        }
        .sheet(isPresented: $sendEmail) {
            SendEmailView()
        }
    }
}

#Preview {
    SettingsView(game: Game(gameLenght: 60))
}
