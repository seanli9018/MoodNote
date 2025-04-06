//
//  User.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//


import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    var photo: String?
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return "MN"
    }
    
    // translate id field
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, photo
    }
}

extension UserModel {
    static var MOCK_USER = UserModel(id: NSUUID().uuidString, name: "Yuxiang Li", email: "test@gmail.com", photo: nil)
}
