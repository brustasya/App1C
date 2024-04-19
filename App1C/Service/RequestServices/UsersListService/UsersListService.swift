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
    func changeTeachers(id: Int, teachers: [Int], completion: @escaping (Result<Data?, Error>) -> Void)
    func getTeachersByCourse(id: Int, completion: @escaping (Result<UsersModel, Error>) -> Void)
    func getTeachers(courseID: Int, completion: @escaping (Result<TeachersModel, Error>) -> Void)
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
    
    func getTeachers(courseID: Int, completion: @escaping (Result<TeachersModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getTeachers(courseID: courseID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func changeTeachers(id: Int, teachers: [Int], completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.changeTeachers(id: id, teachers: teachers)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getTeachersByCourse(id: Int, completion: @escaping (Result<UsersModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getTeachersByCourse(id: id)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
