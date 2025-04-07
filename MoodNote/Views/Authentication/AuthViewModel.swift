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
        case failure(error: Error)
    }
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserModel?
    @Published var errorMessage: String?
    
    // Partially private, setting status is ONLY allowed within the AuthViewModel class.
    private(set) var status: FetchStatus = .idle
    private let authFetcher = AuthService()
    
    private let tokenService = "auth_service"
    private let tokenAccount = "jwt_token"
    private let userDefaultsKey = "current_user"
    
    init() {
        Task { await loadSession() }
    }
    
    func login(withEmail email: String, password: String) async throws {
        status = .fetching
        do {
            // URL session api call to log in user
            let authResponse = try await authFetcher.login(withEmail: email, password: password)
            // Assign data
            self.currentUser = authResponse.data.user
            self.isAuthenticated = true
            status = .success
            persistSession(token: authResponse.token, user: authResponse.data.user)
            self.errorMessage =  nil
        } catch {
            print("User log in failed: \(error.localizedDescription)")
            self.errorMessage = "Login failed. Please check your email and password, or try again later."
            status = .failure(error: error)
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
            self.isAuthenticated = true
            status = .success
            persistSession(token: authResponse.token, user: authResponse.data.user)
            self.errorMessage =  nil
        } catch {
            print("User sign up failed: \(error.localizedDescription)")
            self.errorMessage = "Sign up failed. Please make sure all fields are filled correctly, or try again later."
            status = .failure(error: error)
            self.isAuthenticated = false
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
        self.errorMessage =  nil
        KeychainUtil.delete(service: tokenService, account: tokenAccount)
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    private func persistSession(token: String, user: UserModel) {
        // save token to keychain
        KeychainUtil.save(Data(token.utf8), service: tokenService, account: tokenAccount)
        
        // save current user data to userDefaults as json.
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userDefaultsKey)
        }
    }
    
    private func loadSession() async {
        guard let tokenData = KeychainUtil.read(service: tokenService, account: tokenAccount),
              let token = String(data: tokenData, encoding: .utf8),
              let userData = UserDefaults.standard.data(forKey: userDefaultsKey),
              let user = try? JSONDecoder().decode(UserModel.self, from: userData) else {
            return
        }

        if JWTDecoder.isTokenExpired(token) {
            print("Token expired. Logging out.")
            logout()
        } else {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
}
