//
//  CourseSelectionServer.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CourseSelectionServiceProtocol {
    func getPreliminaryChoise(completion: @escaping (Result<PreliminaryChoiceModel, Error>) -> Void)
    func preliminaryChoise(model: SelectedCoursesModel, completion: @escaping (Result<CoursesIDModel, Error>) -> Void)
}

class CourseSelectionService: CourseSelectionServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: CoursesSelectionURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: CoursesSelectionURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getPreliminaryChoise(completion: @escaping (Result<PreliminaryChoiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getPreliminaryChoise()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func preliminaryChoise(model: SelectedCoursesModel, completion: @escaping (Result<CoursesIDModel, Error>) -> Void) {
        do {
            let request = try requestFactory.preliminaryChoise(model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
