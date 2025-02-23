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
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputFieldFocused: Bool
    @EnvironmentObject private var tabViewModel: TabViewModel
    
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
                    dismiss() // Close the sheet first
                    tabViewModel.selectedTab = 0 // Navigate to dashboard view
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isInputFieldFocused = true
                     }
                 }
        }
        .padding()
    }
}
