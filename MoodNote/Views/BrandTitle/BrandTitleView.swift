//
//  Untitled.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/13/25.
//

import SwiftUI

struct BrandTitleView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "m.circle.fill")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("ood Note")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
