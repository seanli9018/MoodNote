//
//  MoodCreateService.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/6/25.
//


import Foundation
import SwiftUI

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

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
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
    
    func createMyMood(withMoodName name: String, note: String, location: LocationModel?, images: [UIImage]?) async throws -> MoodCreateResponse {
        // Build create my mood url
        let moodCreateURL = baseURL.appendingPathComponent("createMyMood")
        
        guard let tokenData = KeychainUtil.read(service: tokenService, account: tokenAccount),
              let token = String(data: tokenData, encoding: .utf8) else {
            print("Unauthrozied error: Token not found.")
            throw ServiceError.unauthorized // Handle case if token is not found
        }
        
        // Create request
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: moodCreateURL)
        request.httpMethod = "POST"
        
        // ================= Prepare request header =================
        // Set request header: Content-type.
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        // Set reuqest header: Bearer token
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")  // Set Bearer token
        
        // ================= Prepare payload/request body =================
        var body = Data()
        
        // Text fields
        var formFields: [String: String] = [
            "name": name,
            "note": note,
        ]
        
        if let location = location {
            let encoder = JSONEncoder()
            if let jsonData = try? encoder.encode(location),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                formFields["location"] = jsonString
            }
        }
        
        for (key, value) in formFields {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        // images (same field name for each file)
        // Only append images to body when image is NOT empty.
        if let images = images, !images.isEmpty {
            
            for (index, imageData) in images.prefix(3).enumerated() {
                // Need to convert image to jpegData, then able to append to body Data object.
                guard let imageData = imageData.jpegData(compressionQuality: 0.8) else {
                    continue // Skip if conversion fails
                }
                
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image\(index).jpg\"\r\n")
                body.append("Content-Type: image/jpeg\r\n\r\n")
                body.append(imageData)
                body.append("\r\n")
            }
        }
        
        body.append("--\(boundary)--\r\n")
        request.httpBody = body
        
        // Making post request
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
