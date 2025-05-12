//
//  MoodRecentView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 5/11/25.
//

import SwiftUI

struct MoodRecentView: View {
    // Internal dashboard view model data
    @ObservedObject var dashboardViewModel: DashboardViewModel
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var body: some View {
        ForEach(dashboardViewModel.groupedMoodsByDate, id: \.date) { group in
            Section(
                header: Text(formatDate(group.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top)
            ) {
                ForEach(group.moods) { mood in
                    MoodListItem(moodDetails: mood)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                }
            }
        }
    }
}
