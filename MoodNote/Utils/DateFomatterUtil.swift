//
//  DateFomatter.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/11/25.
//

import Foundation

struct DateFormatterUtil {
    static func displayDateFormmatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter.string(from: date)
    }
}
