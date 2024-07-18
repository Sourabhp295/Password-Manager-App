//
//  AccountDetailView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct AccountDetailView: View {
    @State var account: Account
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var managerVM: ManagerViewModel
    @State var showPassword = false
    @State var showingUpdateSheet = false
    
    var body: some View {
        ZStack {
            Color(hex: "#F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                Text("Account Details")
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .foregroundColor(Color(hex: "#3F7DE3"))
                VStack(alignment: .leading) {
                    Text("Account Type")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#CCCCCC"))
                    Text(account.accountName)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                .padding(.vertical, 8)
                VStack(alignment: .leading) {
                    Text("Username/Email")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#CCCCCC"))
                    Text(account.email)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                    
                }
                .padding(.vertical, 8)
                VStack(alignment: .leading) {
                    Text("Password")
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#CCCCCC"))
                    HStack {
                        if showPassword {
                            Text(account.password)
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                        } else {
                            Text(String(repeating: "*", count: account.password.count))
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                        }
                        Spacer()
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image("eye")
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.vertical, 8)
                Spacer()
                HStack {
                    CommonButton(type: .edit) {
                        showingUpdateSheet = true
                    }
                    .sheet(isPresented: $showingUpdateSheet) {
                                            UpdateAccountView(managerVM: managerVM, account: $account)
                                        }
                    CommonButton(type: .delete) {
                        guard let index = managerVM.accounts.firstIndex(where: { $0.id == account.id }) else { return }
                        managerVM.accounts.remove(at: index)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
            .padding(16)
            .padding(.top)
        }
    }
}

//#Preview {
//    AccountDetailView()
//}
