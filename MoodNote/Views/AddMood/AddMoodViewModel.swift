//
//  addMoodViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/7/25.
//

import Foundation
import SwiftUI

@MainActor
class AddMoodViewModel: ObservableObject {
    enum ServiceStatus {
        case idle
        case fetching
        case success
        case failure(error: Error)
    }
    @Published var errorMessage: String?
    @Published private(set) var status: ServiceStatus = .idle
    
    private let moodService = MoodCreateService()
    
    func createMyMood(withMoodName name: String, note: String, location: LocationModel?, images: [UIImage]?) async throws {
        self.status = .fetching
        
        do {
            // URL Session api call to create my mood
            let _ = try await moodService.createMyMood(withMoodName: name, note: note, location: location, images: images)
            
            // Assign data
            self.status = .success
        } catch {
            print("Create mood failed: \(error.localizedDescription)")
            if let nsError = error as? NSError {
                print("User info: \(nsError.userInfo)")
            } else {
                print("Unknown error: \(error.localizedDescription)")
            }
            self.errorMessage = "Create mood failed: Please try again later."
            self.status = .failure(error: error)
        }
    }
}
