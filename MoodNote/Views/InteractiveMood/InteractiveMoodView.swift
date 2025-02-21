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
    @Binding var navigateToDashboard: Bool
    
    var moodIcon: String
    var moodTitle: String
    
    var body: some View {
        // Icon that opens the sheet
        Button(action: {
           isSheetPresented = true
        }) {
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
            InputSheetView(userInput: $userInput, isSheetPresented: $isSheetPresented, navigateToDashboard: $navigateToDashboard)
           Spacer()
        }
    }
}

#Preview {
    InteractiveMoodView(navigateToDashboard: .constant(false), moodIcon: "excited", moodTitle: "Excited")
}
