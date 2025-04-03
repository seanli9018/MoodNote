//
//  SettingRowView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//

import SwiftUI

struct SettingRowView: View {
    let image: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color(.label))
        }
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(image: "gear", title: "Version", tintColor: Color(.gray))
    }
}
