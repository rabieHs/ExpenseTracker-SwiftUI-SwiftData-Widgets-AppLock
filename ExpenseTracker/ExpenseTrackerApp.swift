//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 5/8/2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
