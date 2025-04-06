//
//  AuthViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

import Foundation

// Published changes in the main thread.
@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserModel?
    
    func login(withEmail email: String, password: String) async throws {
        do {
            print("user logged in...")
            // URL session api call to log in user
            // Assign user json in the response to UserModel
            // set isAuthenticated to true
            self.isAuthenticated = true
        } catch {
            print("Error: log in failed.")
            self.isAuthenticated = false
        }
    }
    
    func signup(withEmail email: String, password: String, name: String) async throws {
        do {
            print("user signed up...")
            // URL session api call to create user
            // Assign user json in the response to UserModel
            // set isAuthenticated to true
            self.isAuthenticated = true
        } catch {
            print("Error: sign up failed.")
            self.isAuthenticated = false
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
    }
    
}
