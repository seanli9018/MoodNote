//
//  TabsView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/22/25.
//

import SwiftUI

struct TabsView: View {
    @EnvironmentObject private var tabViewModel: TabViewModel // Access global state/context
    
    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Dashboard")
                }
                .tag(0)
            
            AddMoodView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Mood")
                }
                .tag(1)
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                }
                .tag(2)
        }
        .accentColor(Color(.label))
    }
}
