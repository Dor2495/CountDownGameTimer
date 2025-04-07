//
//  SendEmailView.swift
//  CountDownTimer
//
//  Created by Dor Mizrachi on 06/04/2025.
//

import SwiftUI

struct SendEmailView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    
    @State private var to: String = "dor2495@gmail.com"
    @State private var subject: String = ""
    @State private var bodyContent: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Form {
                    HStack {
                        Text("To:")
                        TextField("To:", text: $to)
                            .disabled(true)
                    }.foregroundStyle(.gray)
                    
                    HStack {
                        Text("Subject:").foregroundStyle(.gray)
                        TextField("", text: $subject)
                    }
                    
                    TextEditor(text: $bodyContent)
                        .frame(minHeight: 100)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Email sending logic will go here
                        sendMail()
                        dismiss()
                        
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.title)
                    }.disabled(subject.isEmpty || bodyContent.isEmpty)
                }
            }
        }
    }
    
    func sendMail() {
        
        if let url = URL(string: "mailto:\(to)?subject=\(subject)&body=\(bodyContent)") {
            openURL(url) { success in
                print(success ? "Successfully sent email" : "Failed to send email")
            }
        }
    }
}

#Preview {
    SendEmailView()
}
