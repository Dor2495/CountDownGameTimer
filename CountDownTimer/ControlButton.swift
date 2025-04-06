//
//  ControlButton.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import SwiftUI

struct ControlButton: View {
    let icon: String
    let size: CGFloat
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(color)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .shadow(color: color.opacity(0.7), radius: 10)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        ControlButton(icon: "play.fill", size: 30, color: .blue, action: {})
        ControlButton(icon: "pause.fill", size: 30, color: .blue, action: {})
        ControlButton(icon: "arrow.clockwise", size: 30, color: .blue, action: {})
        ControlButton(icon: "gear", size: 30, color: .blue, action: {})
    }
    .padding()
    .background(Color.black)
} 
