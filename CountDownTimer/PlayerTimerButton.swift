//
//  PlayerTimerButton.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import SwiftUI

struct PlayerTimerButton: View {
    let display: String
    var color: Color
    let isActive: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(display)
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .minimumScaleFactor(0.4) // Lower minimum scale factor to ensure text fits
                .lineLimit(1)
                .foregroundColor(color)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .shadow(color: color.opacity(0.7), radius: 10)
                )
                .padding(4) // Add padding inside the button
        }
        .scaleEffect(isActive ? 1 : 0.8)
        .disabled(isDisabled)
    }
}

#Preview {
    PlayerTimerButton(
        display: "01:00", color: .blue,
        isActive: true,
        isDisabled: false,
        action: {}
    )
    .frame(width: 200, height: 300)
    .background(Color.black)
} 
