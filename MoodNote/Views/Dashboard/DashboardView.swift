//
//  DashboardView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/20/25.
//

import SwiftUI
import Charts

private func colorForMoodLevel(_ level: Double) -> Color {
    switch level {
    case 80...100:
        return .green
    case 60..<80:
        return .yellow
    case 40..<60:
        return .orange
    default:
        return .red
    }
}

struct DashboardView: View {
    // Internal dashboard view model data
    @StateObject private var viewModel = DashboardViewModel()
    // Global environment tab view model.
    @EnvironmentObject private var tabViewModel: TabViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    MoodBarChartView(dashboardViewModel: viewModel)
                }
                VStack(alignment: .leading) {
                    Text("Your Recent Moods")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                    switch viewModel.status {
                        case .idle, .fetching:
                            ProgressView("Loading moods...")
                                .padding()
                            
                        case .failure(_):
                            VStack(spacing: 12) {
                                Text(viewModel.errorMessage ?? "Something went wrong")
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }
                            
                        case .success:
                            MoodRecentView(dashboardViewModel: viewModel)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Mood Dashboard")
            }
            .onAppear {
                Task {
                    try await viewModel.fetchMyRecentMoods(dataLength: 15)
                    try await viewModel.fetchLast7DaysMoods(force: true)
                }
            }
            // Support: iOS 17+ for onChange(of) without a performer. 
            .onChange(of: tabViewModel.shouldRefreshDashboard) {
                if tabViewModel.shouldRefreshDashboard {
                    Task {
                        try await viewModel.fetchMyRecentMoods(dataLength: 15, force: true)
                        tabViewModel.shouldRefreshDashboard = false
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
