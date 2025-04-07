//
//  JWTDecoder.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/6/25.
//

import Foundation

struct JWTDecoder {
    static func isTokenExpired(_ token: String) -> Bool {
        let parts = token.split(separator: ".")
        guard parts.count == 3 else { return true }

        var base64 = String(parts[1])
        let padding = 4 - base64.count % 4
        if padding < 4 { base64 += String(repeating: "=", count: padding) }

        guard let data = Data(base64Encoded: base64),
              let payload = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let exp = payload["exp"] as? TimeInterval else {
            return true
        }

        return Date() > Date(timeIntervalSince1970: exp)
    }
}
