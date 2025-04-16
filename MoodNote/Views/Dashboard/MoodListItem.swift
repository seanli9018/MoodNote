//
//  MoodListItem.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/11/25.
//

import SwiftUI

struct MoodListItem: View {
    let moodDetails: MoodModel
    @State var isExpanded: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    private func getMoodDisplayName(moodName: MoodName.RawValue) -> String {
        switch moodName {
        case MoodName.satisfied.rawValue:
            return "Satisfied"
        case MoodName.verySatisfied.rawValue:
            return "Very Satisfied"
        case MoodName.excited.rawValue:
            return "Excited"
        case MoodName.neutral.rawValue:
            return "Neutral"
        case MoodName.calm.rawValue:
            return "Calm"
        case MoodName.dissatisfied.rawValue:
            return "Dissatisfied"
        case MoodName.bad.rawValue:
            return "Bad"
        case MoodName.stressed.rawValue:
            return "Stressed"
        case MoodName.frustrated.rawValue:
            return "Frustrated"
        default:
            return "Excited"
        }
    }
    
    var body: some View {
        HStack () {
            Image(MoodMappers.getMoodIconName(moodName: moodDetails.name, colorScheme: colorScheme))
                .resizable()
                .foregroundColor(Color(.label))
                .frame(width: 32, height: 32)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(getMoodDisplayName(moodName: moodDetails.name))
                    .font(.headline)
                Text(DateFormatterUtil.displayDateFormmatter(date: moodDetails.createdAt))
                    .font(.caption)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Toggle button with arrow icon
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
        }
        
        // Expanded details
        if isExpanded {
            VStack(alignment: .leading, spacing: 4) {
                Divider()
                HStack {
                    Spacer()
                        .frame(width: 32, height: 32)
                        .padding(.trailing, 8)
                    Text("Note: \(moodDetails.note)")
                        .font(.subheadline)
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color(.label))
                        .padding(.top, 8)
                }
                
            }
        }
    }
}

struct MoodListItem_Previews: PreviewProvider {
    static var previews: some View {
        MoodListItem(moodDetails: MoodModel.MOCK_MOOD)
    }
}
