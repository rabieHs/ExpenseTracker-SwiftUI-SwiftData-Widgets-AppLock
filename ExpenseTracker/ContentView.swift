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
            Recents().tabItem { Tab.recents.tabContent }.tag(Tab.recents)
           Search().tabItem { Tab.search.tabContent }.tag(Tab.search)
            Graphs().tabItem { Tab.charts.tabContent }.tag(Tab.charts)
            Settings().tabItem { Tab.settings.tabContent }.tag(Tab.settings)
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
