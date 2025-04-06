//
//  LoginViewModel.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

import Combine

class LoginViewModel: ObservableObject, AuthFormProtocol {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var formIsValid: Bool {
        isEmailValid && isPasswordValid
    }
    
    // 👇 Add static preview mock instance
    static let preview: LoginViewModel = {
        let vm = LoginViewModel()
        vm.email = "test@example.com"
        vm.password = "password123"
        return vm
    }()
}
