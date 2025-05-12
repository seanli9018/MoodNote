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
    @Binding var images: [UIImage]
    let moodName: String
    // Its own StateObject for creating new mood.
    @StateObject private var addMoodViewModel = AddMoodViewModel()
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
            // Create Mood Title
            Text("What made you feel this way?")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Text input
            TextEditor(text: $userInput)
                .frame(minHeight: 50, maxHeight: 200)
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
            
            // Image upload input
            VStack(alignment: .leading, spacing: 10 ) {
                HStack {
                    Text("Upload upto 3 images")
                        .font(.caption)
                    Text("(Optional)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                PhotoInputView(selectedImages: $images)
            }.padding(.vertical)
            
            Spacer()
            
            // Submit button
            Button {
                Task {
                    try await addMoodViewModel.createMyMood(
                        withMoodName: moodName,
                        note: userInput,
                        location: nil,
                        images: images
                    )
                    
                    if addMoodViewModel.errorMessage != nil {
                        showError = true
                        return
                    }
                    // if succeed, turn off sheet and navigate to dashboard view.
                    isSheetPresented = false
                    tabViewModel.shouldRefreshDashboard = true // notify that dashboard data need to be refetched once a new mood is created.
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
