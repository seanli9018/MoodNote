//
//  MoodMappers.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/15/25.
//

import Foundation
import SwiftUI

struct MoodMappers {
    static func getMoodIconName(moodName: MoodName.RawValue, colorScheme: ColorScheme = .light) -> String {
        switch moodName {
        case MoodName.satisfied.rawValue:
            return colorScheme == .dark ? "satisfied_dark" : "satisfied"
        case MoodName.verySatisfied.rawValue:
            return colorScheme == .dark ? "very_satisfied_dark" : "very_satisfied"
        case MoodName.excited.rawValue:
            return colorScheme == .dark ? "excited_dark" : "excited"
        case MoodName.neutral.rawValue:
            return colorScheme == .dark ? "neutral_dark" : "neutral"
        case MoodName.calm.rawValue:
            return colorScheme == .dark ? "calm_dark" : "calm"
        case MoodName.dissatisfied.rawValue:
            return colorScheme == .dark ? "dissatisfied_dark" : "dissatisfied"
        case MoodName.bad.rawValue:
            return colorScheme == .dark ? "bad_dark" : "bad"
        case MoodName.stressed.rawValue:
            return colorScheme == .dark ? "stressed_dark" : "stressed"
        case MoodName.frustrated.rawValue:
            return colorScheme == .dark ? "frustrated_dark" : "frustrated"
        default:
            return colorScheme == .dark ? "excited_dark" : "excited"
        }
    }
}
