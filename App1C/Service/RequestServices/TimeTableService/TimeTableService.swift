//
//  TimeTableService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol TimeTableServiceProtocol {
    func timeTable(completion: @escaping (Result<TimeTableServiceModel, Error>) -> Void)
}

class TimeTableService: TimeTableServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: TimeTableURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: TimeTableURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func timeTable(completion: @escaping (Result<TimeTableServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.timeTable()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
