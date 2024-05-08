//
//  DiplomaSpeechesService.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaSpeechesServiceProtocol: AnyObject {
    func getSpeeches(type: String, bachelor: Bool, completion: @escaping (Result<DiplomaSpeechesModel, Error>) -> Void)
    func result(studentID: Int, speechID: Int, result: Bool, completion: @escaping (Result<Data?, Error>) -> Void)
    func getGrades(type: String, bachelor: Bool, completion: @escaping (Result<DiplomaGradesModel, Error>) -> Void)
    func estimate(studentID: Int, gradeID: Int, result: Int, completion: @escaping (Result<Data?, Error>) -> Void)
    func getSpeeches(studentID: Int, bachelor: Bool, completion: @escaping (Result<DiplomaSpeechesResultsServiceModel, Error>) -> Void)
}

class DiplomaSpeechesService: DiplomaSpeechesServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: DiplomaSpeechesURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: DiplomaSpeechesURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getSpeeches(type: String, bachelor: Bool, completion: @escaping (Result<DiplomaSpeechesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getSpeeches(type: type, bachelor: bachelor)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getSpeeches(studentID: Int, bachelor: Bool, completion: @escaping (Result<DiplomaSpeechesResultsServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getSpeeches(studentID: studentID, bachelor: bachelor)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func result(studentID: Int, speechID: Int, result: Bool, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.result(studentID: studentID, speechID: speechID, result: result)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getGrades(type: String, bachelor: Bool, completion: @escaping (Result<DiplomaGradesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getGrades(type: type, bachelor: bachelor)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func estimate(studentID: Int, gradeID: Int, result: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.estimate(studentID: studentID, gradeID: gradeID, result: result)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
