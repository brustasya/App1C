//
//  CoursesAggregationService.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CoursesAggregationServiceProtocol {
    func aggregation(completion: @escaping (Result<CoursesAggregationServiceModel, Error>) -> Void)
    func verdict(id: Int, model: VerdictModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func startChosen(completion: @escaping (Result<Data?, Error>) -> Void)
}

class CoursesAggregationService: CoursesAggregationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: CoursesAggregationURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: CoursesAggregationURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func aggregation(completion: @escaping (Result<CoursesAggregationServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.aggregation()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func verdict(id: Int, model: VerdictModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.verdict(courseID: id, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func startChosen(completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.startChosen()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
