//
//  UserDetailsModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct UserDetailsModel: Codable {
    let secondName: String
    let firstName: String
    let surname: String?
    let telegram: String?
    let workTime: WorkTimeModel?
    
    enum CodingKeys: String, CodingKey {
        case secondName = "second_name"
        case firstName = "first_name"
        case surname = "surname"
        case telegram = "telegram"
        case workTime = "work_time"
    }
}

struct WorkTimeModel: Codable {
    let from: String?
    let to: String?
}