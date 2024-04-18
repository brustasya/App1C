//
//  ErrorModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct ErrorModel: Codable {
    let status: Int
    let code: String
    let message: String
}
