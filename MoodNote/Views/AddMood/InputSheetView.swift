//
//  InputSheetView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/20/25.
//
import SwiftUI

struct InputSheetView: View {
    // passing from its parent
    @Binding var userInput: String
    @Binding var isSheetPresented: Bool
    let moodName: String
    @ObservedObject var addMoodViewModel: AddMoodViewModel
    // environment
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var tabViewModel: TabViewModel
    // its own state
    @FocusState private var isInputFieldFocused: Bool
    @State private var showError = false
    
    var body: some View {
        VStack(alignment: .leading) {
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
            
            Text("What made you feel this way?")
                .font(.title2)
                .fontWeight(.semibold)
            
            TextEditor(text: $userInput)
                .frame(minHeight: 100, maxHeight: 200)
                .padding(4)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .opacity(userInput.isEmpty ? 0.95 : 1) // Subtle fix for better overlay look
                .focused($isInputFieldFocused)
                .onAppear() {
                    Task {
                        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
                        isInputFieldFocused = true
                    }
                 }
            Button {
                Task {
                    try await addMoodViewModel.createMyMood(withMoodName: moodName, note: userInput, location: nil)
                    
                    if addMoodViewModel.errorMessage != nil {
                        showError = true
                        return
                    }
                    // if succeed, turn off sheet and navigate to dashboard view.
                    isSheetPresented = false
                    tabViewModel.selectedTab = 0 // Navigate to dashboard view
                }
            } label: {
                Text("Submit")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.label))
            .cornerRadius(8)
            .padding(.top, 32)
            .opacity(userInput.isEmpty ? 0.5 : 1)
            .disabled(userInput.isEmpty)
            
        }
        .padding()
        .alert("Mood Creation Failure", isPresented: $showError, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(addMoodViewModel.errorMessage ?? "An unknown error occurred.")
        })
    }
}
