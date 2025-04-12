//
//  MoodModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/7/25.
//

import Foundation

enum MoodName: String, Codable {
    case satisfied = "satisfied"
    case verySatisfied = "very-satisfied"
    case excited = "excited"
    case neutral = "neutral"
    case calm = "calm"
    case dissatisfied = "dissatisfied"
    case bad = "bad"
    case stressed = "stressed"
    case frustrated = "frustrated"
}

struct MoodModel: Identifiable, Codable {
    let id: String
    let name: MoodName.RawValue
    let note: String
    let createdAt: Date
    var images: [String]?
    let user: String
    let level: Int
    var location: LocationModel
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, note, createdAt, images, user, level, location
    }
}


extension MoodModel {
    static var MOCK_MOOD: MoodModel = MoodModel(id: NSUUID().uuidString, name: MoodName.excited.rawValue, note: "This is a test note, and it is very long to see how it looks like in the UI. It is very long to see how it looks like in the UI. It is very long to see how it looks like in the UI.", createdAt: Date(), images: nil, user: "123", level: 100, location: LocationModel(type: "Point", coordinates: [123.45, 678.90], address: nil, description: nil))
}
