//
//  AuthResponseModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

struct AuthResponse: Codable {
    let status: String
    let token: String
    let data: UserData
}

struct UserData: Codable {
    let user: UserModel
}
