//
//  TFSError.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

import Foundation

enum TFSError: Error {
    case makeRequest
    case noData
    case redirect
    case badRequest
    case serverError
    case unexpectedStatus
}
