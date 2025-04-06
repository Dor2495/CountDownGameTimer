//
//  SendEmailView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import SwiftUI

struct SendEmailView: View {
    
    @State private var to: String = ""
    @State private var subject: String = ""
    @State private var bodyContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                TextField("To:", text: $to)
                
                TextField("Subject:", text: $subject)
                
                TextEditor(text: $bodyContent)
                    .frame(minHeight: 100)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Email sending logic will go here
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                }
            }
        }
    }
}

#Preview {
    SendEmailView()
}
