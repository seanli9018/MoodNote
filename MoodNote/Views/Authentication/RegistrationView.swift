//
//  RegistrationView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var name = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 64)
                // Login logo
                BrandTitleView(title: "Sign Up")
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email", placeholder: "name@example.com" )
                        .autocapitalization(.none)
                    InputView(text: $name, title: "Full Name", placeholder: "Enter your name" )
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .autocapitalization(.none)
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign in button
                Button {
                    print("Sign up user...")
                } label: {
                    HStack {
                        Text("Sign Up")
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
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Text("Log in")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.label))
                    }
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
