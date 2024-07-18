//
//  PasswordStrengthView.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

import SwiftUI

enum PasswordStrength: Int {
    case none = 0, weak, average, strong
    
    var description: String {
        switch self {
        case .strong:
            return "Strong Password"
        case .average:
            return "Average Password"
        case .weak:
            return "Weak Password"
        case .none:
            return ""
        }
    }
    
    var color: Color {
        switch self {
        case .strong:
            return .green
        case .average:
            return .yellow
        case .weak:
            return .red
        case .none:
            return .gray
        }
    }
    
    static func from(password: String) -> Int {
        guard !password.isEmpty else { return 0 }
        
        let conditions = [
            password.range(of: "[A-Z]", options: .regularExpression) != nil,
            password.range(of: "[a-z]", options: .regularExpression) != nil,
            password.range(of: "[0-9]", options: .regularExpression) != nil,
            password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil,
            password.count >= 8
        ]
        return conditions.filter { $0 }.count
    }
    
    static func strength(for conditionsMet: Int) -> PasswordStrength {
        switch conditionsMet {
        case 5:
            return .strong
        case 3...4:
            return .average
        case 1...2:
            return .weak
        default:
            return .none
        }
    }
}

struct PasswordStrengthView: View {
    @Binding var password: String
    
    var body: some View {
        let conditionsMet = PasswordStrength.from(password: password)
        let strength = PasswordStrength.strength(for: conditionsMet)
        
        VStack {
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Rectangle()
                        .frame(height: 8)
                        .foregroundColor(index < conditionsMet ? strength.color : .gray)
                        .animation(.default, value: password)
                }
            }
            .frame(maxWidth: .infinity)
            Text(strength.description)
                .foregroundColor(strength.color)
                .fontWeight(.bold)
        }
    }
}
