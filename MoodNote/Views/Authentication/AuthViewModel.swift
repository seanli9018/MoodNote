//
//  AuthViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

import Foundation

// Published changes in viewModel observable should be within the main thread.
@MainActor
class AuthViewModel: ObservableObject {
    enum FetchStatus {
        case idle
        case fetching
        case success
        case failure(Error)
    }
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserModel?
    @Published var token: String?
    // Partially private, setting status is ONLY allowed within the AuthViewModel class.
    private(set) var status: FetchStatus = .idle
    private let authFetcher = AuthService()
    
    func login(withEmail email: String, password: String) async throws {
        status = .fetching
        do {
            // URL session api call to log in user
            let authResponse = try await authFetcher.login(withEmail: email, password: password)
            // Assign data
            self.currentUser = authResponse.data.user
            self.token = authResponse.token
            self.isAuthenticated = true
            status = .success
        } catch {
            status = .failure(error)
            self.isAuthenticated = false
        }
    }
    
    func signup(withEmail email: String, password: String, passwordConfirm: String, name: String) async throws {
        status = .fetching
        do {
            // URL session api call to create user
            let authResponse = try await authFetcher.signup(withEmail: email, password: password, passwordConfirm: passwordConfirm, name: name)
            print(authResponse)
            // Assign data
            self.currentUser = authResponse.data.user
            self.token = authResponse.token
            self.isAuthenticated = true
            status = .success
        } catch {
            status = .failure(error)
            self.isAuthenticated = false
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.token = nil
        self.isAuthenticated = false
    }
    
}
