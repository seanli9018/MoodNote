//
//  SignupViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

import Combine

class RegistrationViewModel: ObservableObject, AuthFormProtocol {
    @Published var email: String = ""
    @Published var name = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    // Specific validation ONLY for sign up in addition to AuthFormProtocol.
    var doPasswordsMatch: Bool {
        password == confirmPassword
    }
    
    var isNameValid: Bool {
        !name.isEmpty
    }
    
    var formIsValid: Bool {
        isEmailValid && isPasswordValid && isNameValid && doPasswordsMatch
    }
    
    // 👇 Add static preview mock instance
    static let preview: RegistrationViewModel = {
        let vm = RegistrationViewModel()
        vm.email = "test@example.com"
        vm.name = "Test User"
        vm.password = "password123"
        vm.confirmPassword = "password123"
        return vm
    }()
}
