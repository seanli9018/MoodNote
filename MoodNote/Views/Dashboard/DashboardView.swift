//
//  DashboardView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/20/25.
//

import SwiftUI
import Charts

// Step 1: Define the mood data
struct MoodData {
    var day: String
    var moodLevel: Int
}

struct DashboardView: View {
    // Step 2: Create sample data for mood levels (Happy, Normal, Unhappy)
    let moodData = [
        MoodData(day: "Monday", moodLevel: 100),  // Happy
        MoodData(day: "Tuesday", moodLevel: 50),  // Normal
        MoodData(day: "Wednesday", moodLevel: 0), // Unhappy
        MoodData(day: "Thursday", moodLevel: 75), // Normal
        MoodData(day: "Friday", moodLevel: 90),   // Happy
    ]
    
    var body: some View {
        Text("DashboardView")
        // Step 3: Display a Line Chart using SwiftUI Charts
        Chart {
            ForEach(moodData, id: \.day) { data in
                LineMark(
                    x: .value("Day", data.day),
                    y: .value("Mood Level", data.moodLevel)
                )
                .foregroundStyle(.blue)
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            }
        }
        .frame(height: 300)
        .padding()
    }
}
