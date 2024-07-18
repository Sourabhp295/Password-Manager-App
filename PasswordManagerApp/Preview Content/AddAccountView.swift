//
//  AddAccountView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var managerVM: ManagerViewModel
    @State var accountName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color(hex: "#F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 25) {
                TextField("Account Name", text: $accountName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                
                PasswordStrengthView(password: $password)
                    .padding()
                Spacer()
                CommonButton(type: .addNewAccount) {
                    if fieldsAreValid() {
                        let newAccount = Account(accountName: accountName, email: email, password: password)
                        managerVM.accounts.append(newAccount)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.top)
            .padding(16)
            Spacer()
        }
    }
    
    func fieldsAreValid() -> Bool {
        if accountName.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "Please fill all fields."
            showingAlert = true
            return false
        }
        
        if !email.isValidEmail {
            alertMessage = "Please enter a valid email."
            showingAlert = true
            return false
        }
        
        if managerVM.accounts.contains(where: { $0.accountName.lowercased() == accountName.lowercased() }) {
            alertMessage = "Account name already exists."
            showingAlert = true
            return false
        }
        return true
    }
}


struct UpdateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var managerVM: ManagerViewModel
    @Binding var account: Account
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color(hex: "#F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 25) {
                TextField("Account Name", text: $account.accountName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                
                TextField("Email", text: $account.email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                
                SecureField("Password", text: $account.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
                Spacer()
                CommonButton(type: .update) {
                    if isAccountNameUnique() {
                        managerVM.updateAccount(original: account, updated: account)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        alertMessage = "Account name already exists."
                        showingAlert = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.top)
            .padding(16)
            Spacer()
        }
    }
    func isAccountNameUnique() -> Bool {
        !managerVM.accounts.contains(where: { $0.id != account.id && $0.accountName.lowercased() == account.accountName.lowercased() })
    }
}
