//
//  DashboardViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/12/25.
//

import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    enum ServiceStatus {
        case idle
        case fetching
        case success
        case failure(error: Error)
    }
    @Published var moods: [MoodModel] = []
    @Published var errorMessage: String?
    @Published private(set) var status: ServiceStatus = .idle
    
    private let moodFetchService = MoodFetchService()
    
    func fetchMyRecentMoods(dataLength: Int = 5, force: Bool = false) async throws {
        if !force, case .success = status {
            return // skip the call if not forced and data aleady fetched.
        }
        
        self.status = .fetching
        
        do {
            // URL session api call to fetch my recent moods
            let moodsData = try await moodFetchService.fetchMyRecentMoods(dataLength: dataLength)
            
            // Assign data
            self.status = .success
            moods = moodsData.data.data
        } catch {
            print("Fetch my recent moods failed: \(error.localizedDescription)")
            self.errorMessage = "Unable to get moods data: Please try again later."
            self.status = .failure(error: error)
        }
    }
}
