//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 5/8/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime:Bool =  true
    
    @State private var activeTab: Tab = .recents
    var body: some View {
        TabView(selection: $activeTab)
            {
            Text("Racents").tabItem { Tab.recents.tabContent }.tag(Tab.recents)
            Text("Search").tabItem { Tab.search.tabContent }.tag(Tab.search)
            Text("Charts").tabItem { Tab.charts.tabContent }.tag(Tab.charts)
            Text("Settings").tabItem { Tab.settings.tabContent }.tag(Tab.settings)
        }
            .sheet(isPresented: $isFirstTime, content: {
                IntroView()
                    .interactiveDismissDisabled()
            })
    }
}

#Preview {
    ContentView()
}
