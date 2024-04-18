//
//  TokenService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol TokenServiceProtocol: AnyObject {
    var roles: [Roles] { get }
    var token: String { get set }
    var refreshToken: String { get set }
    var login: String { get }
    var password: String { get }
    func setupLoginData(login: String, password: String, roles: [Roles])
}

final class TokenService: TokenServiceProtocol {
    var roles: [Roles] = []
    var token: String = ""
    var refreshToken: String = ""
    var login: String = ""
    var password: String = ""
    
    static let shared: TokenServiceProtocol = TokenService()
    
    func setupLoginData(login: String, password: String, roles: [Roles]) {
        self.login = login
        self.password = password
        self.roles = roles
    }
}
