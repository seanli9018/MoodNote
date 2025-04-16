//
//  MoodBarChartView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/15/25.
//

import SwiftUI
import Charts

// Data Model after clean up for bar chart use
struct MoodDay: Identifiable {
    let id = UUID()
    let date: Date
    let moodLevelAvg: Double?
    let name: String?
}

struct MoodBarChartView: View {
    // Internal dashboard view model data
    @ObservedObject var dashboardViewModel: DashboardViewModel
    @State private var animateBars = false
    
    var moodsData: [MoodDay] {
        // raw data clean up.
        generateLast7DaysMoodData(from: dashboardViewModel.last7DaysMoods)
    }

    var body: some View {
        if moodsData.isEmpty {
            Text("No mood data available.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
        } else {
            VStack(alignment: .leading) {
                Chart {
                    ForEach(moodsData) { moodDay in
                        if let moodLevel = moodDay.moodLevelAvg {
                            BarMark(
                                x: .value("Date", label(for: moodDay.date)),
                                y: .value("Level", moodLevel)
                            )
                            .foregroundStyle(gradientColor(for: moodLevel))
                            .annotation(position: .overlay) {
                                VStack(spacing: 4) {
                                    if let moodName = moodDay.name {
                                        Image(MoodMappers.getMoodIconName(moodName: moodName))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    
                                    Text("\(Int(moodLevel))")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .monospacedDigit()
                                }
                                .padding(.bottom, 4)
                            }
                        } else {
                            // Optional: invisible or faint bar
                            BarMark(
                                x: .value("Date", label(for: moodDay.date)),
                                y: .value("Level", 0)
                            )
                            .opacity(0.1)
                        }
                    }
                }
                .frame(height: 220)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        animateBars = true
                    }
                }
                
                MoodLegendView()
            }
            .padding()
        }
        
    }
    
    func generateLast7DaysMoodData(from rawData: [AggregateMoodsByDate]) -> [MoodDay] {
            let calendar = Calendar.current
            let today = Date()

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone.current // Ensure it uses local time
        
            let last7Dates: [Date] = (0..<7).compactMap {
                calendar.date(byAdding: .day, value: -$0, to: today)
            }.reversed()
        
            let moodDict: [String: AggregateMoodsByDate] = Dictionary(uniqueKeysWithValues: rawData.map {
                ($0.date, $0)
            })

            return last7Dates.map { date in
                let dateString = formatter.string(from: date)
                if let mood = moodDict[dateString] {
                    return MoodDay(date: date, moodLevelAvg: mood.moodLevelAvg, name: mood.name)
                } else {
                    return MoodDay(date: date, moodLevelAvg: nil, name: nil)
                }
            }
        }

    func label(for date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Tday"
        } else if calendar.isDateInYesterday(date) {
            return "Yday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            return formatter.string(from: date)
        }
    }

    func gradientColor(for value: Double) -> LinearGradient {
        let color: Color
        switch value {
        case ..<30:
            color = Color.red
        case 30..<60:
            color = Color.orange
        case 60..<75:
            color = Color.yellow
        case 75...:
            color = Color.green
        default:
            color = Color.gray
        }
        return LinearGradient(colors: [color.opacity(0.6), color.opacity(1.0)], startPoint: .bottom, endPoint: .top)
    }
}

// Extension to treat Date as identifiable key
extension Date {
    func asDate() -> Date {
        return self
    }
}
