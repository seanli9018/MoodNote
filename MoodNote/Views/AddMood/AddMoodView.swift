//
//  AddMoodView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/22/25.
//

//
//  ContentView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/12/25.
//

import SwiftUI

struct AddMoodView: View {
    @Environment(\.colorScheme) var colorScheme
    
    // Define the grid layout with 4 flexible columns
    let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
    ]
    
    var body: some View {
        VStack {
            BrandTitleView(title: "ood Note")
            Text("What is your mood today?")
                .font(.title2)
                .padding(2)
            Spacer()
                .frame(height: 48)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    Section(header: Text("Positive mood?")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ) {
                        Group {
                            InteractiveMoodView(moodIcon:
                                                        colorScheme == .dark
                                                    ? "satisfied_dark"
                                                    : "satisfied",
                                                moodTitle: "Satisfied",
                                                moodName: "satisfied")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "very_satisfied_dark"
                                                : "very_satisfied",
                                                moodTitle: "Very satisfied",
                                                moodName: "very-satisfied")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "excited_dark"
                                                : "excited",
                                                moodTitle: "Excited",
                                                moodName: "excited")
                        }
                    }
                    Spacer()
                        .frame(minHeight: 32, maxHeight: 48)
                    Section(header: Text("A ordenary day?")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ) {
                        Group {
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "neutral_dark"
                                                : "neutral",
                                                moodTitle: "Neutral",
                                                moodName: "neutral")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "calm_dark"
                                                : "calm",
                                                moodTitle: "Calm",
                                                moodName: "calm")
                            Color.clear // Empty space for the 3rd column
                        }
                    }
                    Spacer()
                        .frame(minHeight: 32, maxHeight: 48)
                    Section(header: Text("Feeling unhappy?")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ) {
                        Group {
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "dissatisfied_dark"
                                                : "dissatisfied",
                                                moodTitle: "Dissatisfied",
                                                moodName: "dissatisfied")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "bad_dark"
                                                : "bad",
                                                moodTitle: "Bad",
                                                moodName: "bad")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "stressed_dark"
                                                : "stressed",
                                                moodTitle: "Stressed",
                                                moodName: "stressed")
                            InteractiveMoodView(moodIcon:
                                                    colorScheme == .dark
                                                ? "frustrated_dark"
                                                : "frustrated",
                                                moodTitle: "Frustrated",
                                                moodName: "frustrated")
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}
