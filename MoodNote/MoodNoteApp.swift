//
//  MoodNoteApp.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/12/25.
//

import SwiftUI

@main
struct MoodNoteApp: App {
    // Shared tab view model owned here.
    @StateObject private var tabViewModel = TabViewModel()
    // Shared auth view model owned here: with currentUser: UserModel data and isAuthenticated: Bool data.
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            // environment state/context providing to all subviews
            MoodNoteView()
                .environmentObject(tabViewModel)
                .environmentObject(authViewModel)
        }
    }
}
