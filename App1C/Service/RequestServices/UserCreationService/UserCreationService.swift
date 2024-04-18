//
//  UserCreationService.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol UserCreationServiceProtocol {
    func createStudent(model: CreateStudentModel ,completion: @escaping (Result<[String: Int], Error>) -> Void)
}

class UserCreationService: UserCreationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: UserCreationURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: UserCreationURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func createStudent(model: CreateStudentModel ,completion: @escaping (Result<[String: Int], Error>) -> Void) {
        do {
            let request = try requestFactory.createStudent(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
