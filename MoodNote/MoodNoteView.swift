//
//  ContentView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/12/25.
//

import SwiftUI

struct MoodNoteView: View {
    @EnvironmentObject private var tabViewModel: TabViewModel // Access global state/context
    
    var body: some View {
        TabsView()
            .onAppear {
                tabViewModel.selectedTab = 1
            }
    }
    
}

#Preview {
    let mockSelection = TabViewModel()
    MoodNoteView()
        .environmentObject(mockSelection) // Inject mock environment object
}
