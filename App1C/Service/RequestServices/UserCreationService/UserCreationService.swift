//
//  UserCreationService.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol UserCreationServiceProtocol {
    func createStudent(model: CreateStudentModel ,completion: @escaping (Result<Data?, Error>) -> Void)
    func createTeacher(model: CreateUserModel ,completion: @escaping (Result<Data?, Error>) -> Void)
    func createAdmin(model: CreateUserModel ,completion: @escaping (Result<Data?, Error>) -> Void)
}

class UserCreationService: UserCreationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: UserCreationURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: UserCreationURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func createStudent(model: CreateStudentModel ,completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createStudent(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createTeacher(model: CreateUserModel ,completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createTeacher(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createAdmin(model: CreateUserModel ,completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createAdmin(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
