//
//  TokenService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol TokenServiceProtocol: AnyObject {
    var roles: [Roles] { get }
    var role: Roles { get set }
    var token: String { get set }
    var refreshToken: String { get set }
    var id: Int { get set }
    var login: String { get }
    var password: String { get }
    var chatURL: String { get set }
    func setupLoginData(login: String, password: String, roles: [Roles])
}

final class TokenService: TokenServiceProtocol {
    var roles: [Roles] = []
    var role: Roles = .student
    var token: String = ""
    var refreshToken: String = ""
    var id: Int = 0
    var login: String = ""
    var password: String = ""
    var chatURL: String = ""
    
    static let shared: TokenServiceProtocol = TokenService()
    
    func setupLoginData(login: String, password: String, roles: [Roles]) {
        self.login = login
        self.password = password
        self.roles = roles
    }
}
