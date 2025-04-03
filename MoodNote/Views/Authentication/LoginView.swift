//
//  LoginView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 64)
                // Login logo
                BrandTitleView(title: "Login")
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email,title: "Email", placeholder: "name@example.com" )
                        .autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign in button
                Button {
                    print("Log user in...")
                } label: {
                    HStack {
                        Text("LOG IN")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.label))
                .cornerRadius(8)
                .padding(.top, 32)
                
                Spacer()
                
                // Sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Text("Sign up")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.label))
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
