//
//  FetchAuthService.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/6/25.
//


import Foundation

struct AuthResponse: Codable {
    let status: String
    let token: String
    let data: UserData
}

struct UserData: Codable {
    let user: UserModel
}

struct AuthService {
    private enum FetchError: Error {
        case badRequest
        case badResponse
    }
    
    private let baseURL = URL(string: "http://localhost:3000/api/v1/users")!
    
    func login(withEmail email: String, password: String) async throws -> AuthResponse {
        // Build user login url
        let loginURL = baseURL
            .appendingPathComponent("login")
            
        // Build payload/request body in json
        let payload = ["email": email, "password": password]
        guard let body = try? JSONEncoder().encode(payload) else {
            throw FetchError.badRequest
        }
        
        // Prepare request
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        return authResponse
    }
    
    func signup(withEmail email: String, password: String, passwordConfirm: String, name: String) async throws -> AuthResponse {
        // Build user signup url
        let signupURL = baseURL.appendingPathComponent("signup")
        
        // Build payload/request body in json
        let payload = ["email": email, "password": password, "passwordConfirm": passwordConfirm, "name": name]
        guard let body = try? JSONEncoder().encode(payload) else {
            throw FetchError.badRequest
        }
        
        // Prepare request
        var request = URLRequest(url: signupURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Send HTTP request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        return authResponse
    }
}
