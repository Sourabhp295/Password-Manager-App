//
//  PinAuthenticationView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct PinAuthenticationView: View {
    @Binding var isAuthenticated: Bool
    @State private var pin: String = ""
    @State private var showingAlert = false
    let correctPin = "1234"

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter PIN")
                .font(.title)
            
            SecureField("PIN", text: $pin)
                .padding()
                .keyboardType(.numberPad)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            Button("Unlock") {
                if pin == correctPin {
                    isAuthenticated = true
                } else {
                    showingAlert = true
                    pin = ""
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid PIN"), message: Text("Please enter correct PIN"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}
