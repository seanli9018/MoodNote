//
//  LoginView.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/2/25.
//

import SwiftUI

struct LoginView: View {
    // Global view model for authentication.
    @EnvironmentObject private var authViewModel: AuthViewModel
    // its own view model
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 64)
                // Login logo
                BrandTitleView(title: "Login")
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $loginViewModel.email,title: "Email", placeholder: "name@example.com" )
                        .autocapitalization(.none)
                    InputView(text: $loginViewModel.password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Log in button
                Button {
                    // TODO, if the login goes wrong, need to show error on the view
                    Task {
                        try await authViewModel.login(
                                    withEmail: loginViewModel.email,
                                    password: loginViewModel.password)
                        if authViewModel.errorMessage != nil {
                            showError = true
                        }
                    }
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
                .opacity(!loginViewModel.formIsValid ? 0.5 : 1)
                .disabled(!loginViewModel.formIsValid)
                
                Spacer()
                
                // Sign up button
                NavigationLink {
                    RegistrationView(registrationViewModel: RegistrationViewModel())
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
            .alert("Login Failure", isPresented: $showError, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(authViewModel.errorMessage ?? "An unknown error occurred.")
            })
        }
        .hideKeyboardOnTap()
    }
}

struct LoginView_Previews: PreviewProvider {
    static let authPreview = AuthViewModel()

    static var previews: some View {
        LoginView(loginViewModel: .preview)
            .environmentObject(authPreview)
    }
}
