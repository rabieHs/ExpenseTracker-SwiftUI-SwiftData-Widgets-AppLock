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
    var amount: String
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: String, dateAdded: Date, category: Category, tintColor: TintColor) {
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
