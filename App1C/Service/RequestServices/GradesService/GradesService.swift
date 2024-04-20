//
//  GradesService.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

protocol GradesServiceProtocol {
    func estimate(courseID: Int, studentID: Int, model: EstimateServerModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func finishEstimation(courseID: Int, completion: @escaping (Result<Data?, Error>) -> Void)
    func getGrades(studentID: Int, completion: @escaping (Result<CoursesGradesModel, Error>) -> Void)
}

class GradesService: GradesServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: GradesURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: GradesURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getGrades(studentID: Int, completion: @escaping (Result<CoursesGradesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getGrades(studentID: studentID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    
    func estimate(courseID: Int, studentID: Int, model: EstimateServerModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.estimate(courseID: courseID, studentID: studentID, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func finishEstimation(courseID: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.finishEstimation(courseID: courseID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
