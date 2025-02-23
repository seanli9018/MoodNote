//
//  TabsViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/22/25.
//

import SwiftUI
import Combine

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0 // Default tab
}
