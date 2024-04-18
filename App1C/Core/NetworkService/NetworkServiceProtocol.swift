//
//  NetworkServiceProtocol.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
