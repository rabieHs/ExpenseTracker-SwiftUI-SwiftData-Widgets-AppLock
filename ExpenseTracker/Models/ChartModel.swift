//
//  ChartModel.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 9/8/2024.
//

import Foundation

struct ChartGroup: Identifiable{
    let id = UUID()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable {
    let id =  UUID()
    var category: Category
    var total: Double
    
}
