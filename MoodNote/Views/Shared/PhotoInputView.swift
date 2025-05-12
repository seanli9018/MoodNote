//
//  PhotoInputView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 5/11/25.
//

import SwiftUI
import PhotosUI

public struct PhotoInputView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @Binding var selectedImages: [UIImage]
    
    public var body: some View {
        VStack (alignment: .leading) {
            // Photo Picker/Input
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 3 - selectedImages.count,
                matching: .images,
                photoLibrary: .shared()
            ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)

                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .onChange(of: selectedItems) { _, newItems in
                Task {
                    for item in newItems {
                        if selectedImages.count >= 3 { break }
                        
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImages.append(uiImage)
                        }
                    }
                    selectedItems = [] // Reset picker items.
                }
            }
            
            // Image Previews
            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedImages.indices, id: \.self) {index in
                        ZStack (alignment: .topTrailing) {
                            Image(uiImage: selectedImages[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipped(antialiased: true)
                                .cornerRadius(10)
                            
                            Button(action: {
                                selectedImages.remove(at: index)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Circle().fill(Color(.label).opacity(0.7)))
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
