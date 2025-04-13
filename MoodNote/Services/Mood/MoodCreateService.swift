//
//  MoodCreateService.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/6/25.
//


import Foundation

struct MoodCreateRequest: Encodable {
    let name: String
    let note: String
    let location: LocationModel?
}

struct MoodCreateResponse: Decodable {
    let status: String
    let data: MoodCreateData
}

struct MoodCreateData: Decodable {
    let data: MoodModel
}

struct MoodCreateService {
    private enum ServiceError: Error {
        case badRequest
        case unauthorized
        case badResponse
    }
    
    private let baseURL = URL(string: "http://localhost:3000/api/v1/moods")!
    private let tokenService = "auth_service"
    private let tokenAccount = "jwt_token"
    
    func createMyMood(withMoodName name: String, note: String, location: LocationModel?) async throws -> MoodCreateResponse {
        
        // Build create my mood url
        let moodCreateURL = baseURL.appendingPathComponent("createMyMood")
        
        // Build payload/request body in json
        let payload = MoodCreateRequest(name: name, note: note, location: location)
        guard let body = try? JSONEncoder().encode(payload) else {
            print("Bad request error: payload cannot be encoded to json.")
            throw ServiceError.badRequest
        }
        
        guard let tokenData = KeychainUtil.read(service: tokenService, account: tokenAccount),
              let token = String(data: tokenData, encoding: .utf8) else {
            print("Unauthrozied error: Token not found.")
            throw ServiceError.unauthorized // Handle case if token is not found
        }
        
        // Prepare request
        var request = URLRequest(url: moodCreateURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Set Bearer token
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")  // Set Bearer token
        request.httpBody = body
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Handle response
        // Safely cast the response to HTTPURLResponse to access statusCode
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error: Response is not an HTTP URL response")
            throw ServiceError.badResponse
        }
        // Check for a 201 status code (successful creation)
        guard httpResponse.statusCode == 201 else {
            print("Bad response error: Status code is \(httpResponse.statusCode)")
            throw ServiceError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        decoder.dateDecodingStrategy = .formatted(formatter)
        let moodCreateResponse = try decoder.decode(MoodCreateResponse.self, from: data)
        print("Mood created successfully: \(moodCreateResponse)")
        
        return moodCreateResponse
    }
}
