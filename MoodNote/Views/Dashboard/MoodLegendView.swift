//
//  MoodLegendView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/15/25.
//

import SwiftUI

struct MoodLegendView: View {
    private func legendItem(color: Color, label: String) -> some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            Text(label)
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Text("Mood Intensity")
                .font(.caption)
            LinearGradient(colors: [.red, .yellow, .green], startPoint: .leading, endPoint: .trailing)
                .frame(width: 100, height: 10)
                .cornerRadius(5)
        }
        .padding(.top, 4)
    }
}

