//
//  UsersListService.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol UsersListServiceProtocol {
    func getStudentsByYear(course: Int, completion: @escaping (Result<StudentsModel, Error>) -> Void)
    func getAdmins(completion: @escaping (Result<AdminsModel, Error>) -> Void)
    func getTeachers(completion: @escaping (Result<TeachersModel, Error>) -> Void)
}

class UsersListService: UsersListServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: UsersListURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: UsersListURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getStudentsByYear(course: Int, completion: @escaping (Result<StudentsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getStudentsByYear(course: course)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getAdmins(completion: @escaping (Result<AdminsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getAdmins()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getTeachers(completion: @escaping (Result<TeachersModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getTeachers()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
