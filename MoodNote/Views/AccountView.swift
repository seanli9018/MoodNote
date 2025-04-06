//
//  AccountView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 2/22/25.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(UserModel.MOCK_USER.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .frame(width: 72, height: 72)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(UserModel.MOCK_USER.name)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text(UserModel.MOCK_USER.email)
                            .font(.footnote)
                            .foregroundColor(Color(.gray))
                    }
                }
            }
            
            Section("General") {
                HStack {
                    SettingRowView(image: "gear",
                                   title: "Version",
                                   tintColor: Color(.gray))
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(Color(.gray))
                }
                
            }
            
            Section("Message") {
                Button{
                    print("check out message...")
                } label: {
                    HStack {
                        SettingRowView(image: "bell.circle.fill",
                                       title: "10 new messages",
                                       tintColor: Color(.blue))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.gray))
                    }
                }
                
            }
            
            Section("Account") {
                // Update user profile button.
                Button{
                    print("update profile...")
                } label: {
                    SettingRowView(image: "person.crop.circle.fill",
                                   title: "Update Profile",
                                   tintColor: Color(.orange))
                }
                // Update password button
                Button{
                    print("update password...")
                } label: {
                    SettingRowView(image: "lock.circle.fill",
                                   title: "Update Password",
                                   tintColor: Color(.orange))
                }
                // Sign out button
                Button{
                    authViewModel.logout()
                } label: {
                    SettingRowView(image: "arrowshape.left.circle.fill",
                                   title: "Sign Out",
                                   tintColor: Color(.red))
                }
                
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
