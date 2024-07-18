//
//  CommonButton.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import Foundation
import SwiftUI

enum ButtonType {
    case edit
    case delete
    case addNewAccount
    case update

    var backgroundColor: Color {
        switch self {
        case .edit, .addNewAccount, .update:
            return Color(hex: "#2C2C2C")
        case .delete:
            return Color(hex: "#F04646")
        }
    }

    var title: String {
        switch self {
        case .edit:
            return "Edit"
        case .delete:
            return "Delete"
        case .addNewAccount:
            return "Add New Account"
        case .update:
            return "Update Account"
        }
    }
}


struct CommonButton: View {
    var type: ButtonType
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(type.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(type.backgroundColor)
            .cornerRadius(20)
        }
    }
}
