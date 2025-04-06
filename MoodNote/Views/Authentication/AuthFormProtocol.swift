//
//  AuthFormProtocol.swift
//  MoodNote
//
//  Created by Yuxiang Li on 4/5/25.
//

import Foundation

// Shared Auth form validation: email and password.
protocol AuthFormProtocol {
    var email: String { get }
    var password: String { get }
    var formIsValid: Bool { get }
}

extension AuthFormProtocol {
    var isEmailValid: Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
        return password.count >= 8
    }
}
