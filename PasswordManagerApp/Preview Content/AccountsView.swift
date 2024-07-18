//
//  AccountsView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct AccountsView: View {
    @ObservedObject var managerVM: ManagerViewModel
    var selectAccount: (Account) -> Void
    
    var body: some View {
        ForEach(managerVM.accounts) { account in
            HStack {
                Text(account.accountName)
                    .fontWeight(.bold)
                    .padding(.trailing, 8)
                Text(String(repeating: "*", count: account.password.count))
                    .foregroundColor(Color(hex: "#C6C6C6"))
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                Spacer()
                Image("rightArrow")
                    .padding()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(50)
            .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color(hex: "#EDEDED"), lineWidth: 1))
            .onTapGesture {
                selectAccount(account)
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Password Manager")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                Spacer()
            }
            .padding(.leading)
            Divider()
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    AccountsView()
//}
