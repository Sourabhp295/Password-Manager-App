//
//  PasswordManagerView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

struct PasswordManagerView: View {
    @State var showAddAccountView = false
    @StateObject var managerVM = ManagerViewModel()
    @State var selectedAccount: Account?
    
    var body: some View {
        VStack {
            TopView()
            ScrollView {
                VStack {
                    AccountsView(managerVM: managerVM, selectAccount: { account in
                        self.selectedAccount = account
                    })
                }
            }
            .padding(.horizontal)
        }
        .overlay (
            Button {
                self.showAddAccountView = true
            } label: {
                Image("add")
                    .frame(width: 60, height: 60)
                    .background(Color(hex: "#3F7DE3"))
                    .cornerRadius(10)
            }
                .padding(.trailing, 30)
                .padding(.bottom, 30),
            alignment: .bottomTrailing
        )
        .sheet(isPresented: $showAddAccountView) {
            AddAccountView(managerVM: managerVM)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $selectedAccount) { account in
            AccountDetailView(account: account, managerVM: managerVM)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    PasswordManagerView()
}
