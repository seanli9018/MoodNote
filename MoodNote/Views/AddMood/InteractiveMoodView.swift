//
//  InteractiveMoodView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/14/25.
//

import SwiftUI

struct InteractiveMoodView: View {
    @State private var isSheetPresented = false
    @State private var userInput = ""
    @FocusState private var isInputFieldFocused: Bool
    
    let moodIcon: String
    let moodTitle: String
    let moodName: String
    
    var body: some View {
        // Icon that opens the sheet
        Button{
            isSheetPresented = true
        } label:  {
            VStack {
               Image(moodIcon)
                   .resizable()
                   .foregroundColor(.red)
                   .frame(width: 36, height: 36)
               Text(moodTitle)
                   .font(.system(size: 16))
                   .foregroundColor(Color(.label))
           }
        }
        .sheet(isPresented: $isSheetPresented) {
            InputSheetView(userInput: $userInput, isSheetPresented: $isSheetPresented, moodName: moodName)
           Spacer()
        }
    }
}

#Preview {
    InteractiveMoodView(moodIcon: "excited", moodTitle: "Excited", moodName: "excited")
}
