//
//  DashboardView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/20/25.
//

import SwiftUI
import Charts

// Step 1: Define the mood data
struct MoodData: Identifiable {
    let id = UUID()
    let date: Date
    let moodLevel: Int
}

// Sample mood data
let sampleMoodData: [MoodData] = [
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 16))!, moodLevel: 3),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 17))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 18))!, moodLevel: 4),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 19))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 20))!, moodLevel: 6),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 21))!, moodLevel: 7),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 22))!, moodLevel: 8),
]

let sampleMoodDateByMonth: [MoodData] = [
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1))!, moodLevel: 3),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 1))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 1))!, moodLevel: 4),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 1))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!, moodLevel: 6),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 1))!, moodLevel: 7),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 7, day: 1))!, moodLevel: 8),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 1))!, moodLevel: 3),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 1))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 10, day: 1))!, moodLevel: 4),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 11, day: 1))!, moodLevel: 5),
    MoodData(date: Calendar.current.date(from: DateComponents(year: 2025, month: 12, day: 2))!, moodLevel: 6),
]

enum FilterOption: String, CaseIterable {
    case week = "Week"
    case month = "Month"
}

struct DashboardView: View {
    @State private var filter: FilterOption = .week
    
    // Filter the data based on the selected option
    var filteredData: [MoodData] {
        switch filter {
        case .week:
            // Filter data for the current week
            let currentWeek = Calendar.current.component(.weekOfYear, from: Date())
            return sampleMoodData.filter { Calendar.current.component(.weekOfYear, from: $0.date) == currentWeek }
        case .month:
            // Filter data for the current year (to show all months)
            let currentYear = Calendar.current.component(.year, from: Date())
            return sampleMoodDateByMonth.filter { Calendar.current.component(.year, from: $0.date) == currentYear }
        }
    }
    
    // Helper function to format day names (e.g., "Mon", "Tue")
    private func dayName(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // "E" gives short day name (e.g., "Mon")
        return formatter.string(from: date)
    }
    
    // Helper function to format month names (e.g., "Jan", "Feb")
    private func monthName(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM" // "MMM" gives short month name (e.g., "Jan")
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Filter Picker
                Picker("Filter", selection: $filter) {
                    ForEach(FilterOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Line Chart
                Chart(filteredData) { dataPoint in
                   LineMark(
                       x: .value("Date", dataPoint.date, unit: filter == .week ? .day : .month),
                       y: .value("Mood Level", dataPoint.moodLevel)
                   )
                   .interpolationMethod(.catmullRom) // Smooth line
                   .foregroundStyle(Color(.label)) // Change line color

                   PointMark(
                       x: .value("Date", dataPoint.date, unit: filter == .week ? .day : .month),
                       y: .value("Mood Level", dataPoint.moodLevel)
                   )
                   .foregroundStyle(Color(.label)) // Change point mark color
                   .symbolSize(15) // Size of the points
               }
                .chartXAxis {
                    AxisMarks(values: .stride(by: filter == .week ? .day : .month)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel {
                                if filter == .week {
                                    Text(dayName(from: date)) // Format day name for weekly filter
                                } else {
                                    Text(monthName(from: date)) // Format week name for monthly filter
                                }
                            }
                        }
                    }
                }
               .accentColor(Color(.label))
               .frame(height: 200)
               .padding()
                
                Spacer()
            }
            .navigationTitle("Mood Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
