//
//  MoodFetchService.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/12/25.
//

import Foundation

struct FetchMoodsResponse: Decodable {
    let status: String
    let results: Int
    let data: MoodsData
}

struct MoodsData: Decodable {
    let data: [MoodModel]
}

struct FetchLast7DaysMoodsResponse: Decodable {
    let status: String
    let data: Last7DaysMoodData
}

struct Last7DaysMoodData: Decodable {
    let myLast7DaysMoods: [AggregateMoodsByDate]
}

struct AggregateMoodsByDate: Identifiable, Decodable {
    var id: String { date }
    let date: String // Format: "2025-04-13"
    let moodLevelAvg: Double
    let name: MoodName.RawValue
}

struct MoodFetchService {
    private enum ServiceError: Error {
        case badRequest
        case badResponse
        case unauthorized
    }
    
    private let baseURL = URL(string:"http://localhost:3000/api/v1/moods")!
    private let tokenService = "auth_service"
    private let tokenAccount = "jwt_token"
    
    func fetchMyRecentMoods(dataLength: Int = 15) async throws -> FetchMoodsResponse {
        
        // Build fetch my recent moods url
        let fetchMyRecentMoodsURL = baseURL.appendingPathComponent("getMyMoods")
        
        // Create URLComponents from url
        var components = URLComponents(url: fetchMyRecentMoodsURL, resolvingAgainstBaseURL: false)!
        
        // Add query paramters
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(dataLength)")
        ]
        
        // Safely unwrap final URL
        guard let finalURL = components.url else {
            throw ServiceError.badRequest
        }
        
        guard let tokenData = KeychainUtil.read(service: tokenService, account: tokenAccount),
              let token = String(data: tokenData, encoding: .utf8) else {
            print("Unauthrozied error: Token not found.")
            throw ServiceError.unauthorized // Handle case if token is not found
        }
        
        // Prepare request
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check for response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.badResponse
        }
        
        // Check for 2xx status code
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        let recentMoodsResponse = try decoder.decode(FetchMoodsResponse.self, from: data)
        
        print("Moods fetched successfully!")
        
        return recentMoodsResponse
    }
    
    func fetchLast7DaysMoods() async throws -> FetchLast7DaysMoodsResponse {
        // Build fetch my last 7 days moods url
        let fetchLast7DaysMoodsURL = baseURL.appendingPathComponent("last-7-days")
        
        // Create URLComponents from url
        var components = URLComponents(url: fetchLast7DaysMoodsURL, resolvingAgainstBaseURL: false)!
        
        // Add query paramters
        components.queryItems = [
            URLQueryItem(name: "timezone", value: TimeZone.current.identifier) // Automatically uses user's timezone
        ]
        
        // Safely unwrap final URL
        guard let finalURL = components.url else {
            throw ServiceError.badRequest
        }
        
        guard let tokenData = KeychainUtil.read(service: tokenService, account: tokenAccount),
              let token = String(data: tokenData, encoding: .utf8) else {
            print("Unauthrozied error: Token not found.")
            throw ServiceError.unauthorized // Handle case if token is not found
        }
        
        // Prepare request
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check for response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.badResponse
        }
        
        // Check for 2xx status code
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.badResponse
        }
        
        let decoder = JSONDecoder()
        let last7DaysMoodsResponse = try decoder.decode(FetchLast7DaysMoodsResponse.self, from: data)
        
        print("Last 7 days moods fetched successfully!")
        
        return last7DaysMoodsResponse
    }
    
}
