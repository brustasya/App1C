//
//  VerificationViewOutput.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

protocol VerificationViewOutput: AnyObject {
    func loginButtonTapped(login: String, password: String)
}
