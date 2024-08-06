//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 5/8/2024.
//
import Foundation
import SwiftUI

struct Transaction : Identifiable {
    let id = UUID()
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    var color: Color{
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
}

var
sampleTransactions: [Transaction] = [
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Apple Music", remarks: "Subscriptions", amount: 10.99, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "iCloud+", remarks: "Subscriptions", amount: 0.99, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Payment", remarks: "Payment Recieved!", amount: 500, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
]
