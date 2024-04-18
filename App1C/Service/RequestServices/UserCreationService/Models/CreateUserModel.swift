//
//  CreateUserModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct CreateUserModel: Codable {
    let secondName: String
    let firstName: String
    let surname: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case secondName = "second_name"
        case firstName = "first_name"
        case surname = "surname"
        case email = "email"
    }
}
