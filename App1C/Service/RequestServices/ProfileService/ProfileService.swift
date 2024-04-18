//
//  ProfileService.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol ProfileServiceProtocol {
    func getStudent(id: Int, completion: @escaping (Result<StudentDetailsModel, Error>) -> Void)
    func modifyStudent(id: Int, model: StudentDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func getTeacher(id: Int, completion: @escaping (Result<UserDetailsModel, Error>) -> Void)
    func modifyTeacher(id: Int, model: UserDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func getAdmin(id: Int, completion: @escaping (Result<UserDetailsModel, Error>) -> Void)
    func modifyAdmin(id: Int, model: UserDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void)
}

class ProfileService: ProfileServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let requestFactory: ProfileURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: ProfileURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getStudent(id: Int, completion: @escaping (Result<StudentDetailsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getStudent(id: id)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func modifyStudent(id: Int, model: StudentDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.modifyStudent(id: id, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getTeacher(id: Int, completion: @escaping (Result<UserDetailsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getTeacher(id: id)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func modifyTeacher(id: Int, model: UserDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.modifyTeacher(id: id, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getAdmin(id: Int, completion: @escaping (Result<UserDetailsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getAdmin(id: id)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func modifyAdmin(id: Int, model: UserDetailsModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.modifyAdmin(id: id, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
