//
//  RegistrationView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    // Global view model
    @EnvironmentObject private var authViewModel: AuthViewModel
    // Its own view model
    @ObservedObject var registrationViewModel: RegistrationViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 64)
                // Login logo
                BrandTitleView(title: "Sign Up")
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $registrationViewModel.email, title: "Email", placeholder: "name@example.com" )
                        .autocapitalization(.none)
                    InputView(text: $registrationViewModel.name, title: "Full Name", placeholder: "Enter your name" )
                    InputView(text: $registrationViewModel.password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .textContentType(.oneTimeCode) // or use .newPassword if you want autofill
                        .autocapitalization(.none)
                    InputView(text: $registrationViewModel.confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                        .textContentType(.oneTimeCode) // or use .newPassword if you want autofill
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign up button
                Button {
                    // TODO, if the sign up goes wrong, need to show error on the view
                    Task {
                        try await authViewModel.signup(withEmail: registrationViewModel.email, password: registrationViewModel.password, passwordConfirm: registrationViewModel.confirmPassword, name: registrationViewModel.name)
                    }
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
                .opacity(!registrationViewModel.formIsValid ? 0.5 : 1)
                .disabled(!registrationViewModel.formIsValid)
                
                Spacer()
                
                // Go back to log in view.
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
    static let authPreview = AuthViewModel()

    static var previews: some View {
        RegistrationView(registrationViewModel: .preview)
            .environmentObject(authPreview)
    }
}
