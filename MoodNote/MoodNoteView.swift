//
//  ContentView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/12/25.
//

import SwiftUI

struct MoodNoteView: View {
    // Access global state/context
    @EnvironmentObject private var tabViewModel: TabViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated != false {
                TabsView()
                    .onAppear {
                        tabViewModel.selectedTab = 0
                        // Always go to Dashboard tab when app loaded.
                    }
            } else {
                LoginView(loginViewModel: LoginViewModel()).environmentObject(authViewModel)
            }
        }
    }
    
}

#Preview {
    let mockSelection = TabViewModel()
    let authMock = AuthViewModel()
    
    MoodNoteView()
        // Inject mock environment object
        .environmentObject(mockSelection)
        .environmentObject(authMock)
}
