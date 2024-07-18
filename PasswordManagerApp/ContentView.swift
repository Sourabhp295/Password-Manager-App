//
//  ContentView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            PasswordManagerView()
        } else {
            PinAuthenticationView(isAuthenticated: $isAuthenticated)
        }
    }
}


#Preview {
    ContentView()
}
