//
//  CoursesService.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CoursesServiceProtocol {
    func getCourses(completion: @escaping (Result<CoursesModel, Error>) -> Void)
}

class CoursesService: CoursesServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let requestFactory: CoursesURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: CoursesURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    
    func getCourses(completion: @escaping (Result<CoursesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getCourses()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
