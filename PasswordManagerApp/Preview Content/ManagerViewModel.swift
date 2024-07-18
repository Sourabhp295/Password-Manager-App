//
//  ManagerViewModel.swift
//  PasswordManagerApp
//
//  Created by Sourabh Pandey on 18/07/24.
//

// I have used User Defaults for save the details in the app

import Foundation
import SwiftUI

struct Account: Identifiable, Codable {
   let id = UUID()
   var accountName: String
   var email: String
   var password: String
}

class ManagerViewModel: ObservableObject {
   @Published var accounts: [Account] = [] {
       didSet {
           saveAccounts()
       }
   }

   init() {
       loadAccounts()
   }
   
   private func saveAccounts() {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(accounts) {
           UserDefaults.standard.set(encoded, forKey: "SavedAccounts")
       }
   }
   
   private func loadAccounts() {
       if let savedAccounts = UserDefaults.standard.data(forKey: "SavedAccounts") {
           let decoder = JSONDecoder()
           if let loadedAccounts = try? decoder.decode([Account].self, from: savedAccounts) {
               accounts = loadedAccounts
           }
       }
   }
   
   func updateAccount(original: Account, updated: Account) -> Bool {
           if let index = accounts.firstIndex(where: { $0.id == original.id }) {
               accounts[index] = updated
               saveAccounts()
               return true
           }
           return false
       }
}

extension String {
   var isValidEmail: Bool {
       NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
   }
}


extension Color {
   init(hex: String) {
       let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
       var int: UInt64 = 0
       Scanner(string: hex).scanHexInt64(&int)
       let a, r, g, b: UInt64
       switch hex.count {
       case 3:
           (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
       case 6:
           (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
       case 8:
           (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
       default:
           (a, r, g, b) = (255, 0, 0, 0)
       }
       self.init(
           .sRGB,
           red: Double(r) / 255,
           green: Double(g) / 255,
           blue: Double(b) / 255,
           opacity: Double(a) / 255
       )
   }
}
