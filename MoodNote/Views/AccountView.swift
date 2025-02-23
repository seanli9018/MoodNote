//
//  AccountView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/22/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Step 3: Display a Line Chart using SwiftUI Charts
                Text("Account view")
                .frame(height: 300)
                .padding()
            }
            .navigationTitle("Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
