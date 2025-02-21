//
//  InputSheetView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/20/25.
//
import SwiftUI

struct InputSheetView: View {
    @Binding var userInput: String
    @Binding var isSheetPresented: Bool
    @Binding var navigateToDashboard: Bool
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputFieldFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Action for the close button
                    isSheetPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            
            TextField("What made you feel this way?", text: $userInput, onCommit: {
                if !userInput.isEmpty {
                    dismiss() // close the sheet first
                    navigateToDashboard = true // then navigate
                }
            })
                .padding()
                .cornerRadius(8)
                .overlay(
                 RoundedRectangle(cornerRadius: 8)
                     .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal)
                .focused($isInputFieldFocused)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isInputFieldFocused = true
                     }
                 }
        }
        .padding()
    }
}
