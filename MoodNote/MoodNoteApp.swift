//
//  MoodNoteApp.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/12/25.
//

import SwiftUI

@main
struct MoodNoteApp: App {
    @StateObject private var tabViewModel = TabViewModel() // Shared tab view model owned here
    
    var body: some Scene {
        WindowGroup {
            MoodNoteView()
                .environmentObject(tabViewModel) // environment state/context providing to all subviews
        }
    }
}
