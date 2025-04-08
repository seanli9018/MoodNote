//
//  LocationModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/7/25.
//

import Foundation

struct LocationModel: Codable {
    let type: String?
    let coordinates: [Double]?
    let address: String?
    let description: String?
}
