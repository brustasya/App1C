//
//  DiplomasInfoService.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomasInfoServiceProtocol: AnyObject {
    func getDiplomas(bachelor: Bool, completion: @escaping (Result<DiplomasModel, Error>) -> Void)
    func getDiplomaDetails(studentID: Int, completion: @escaping (Result<DiplomaInfoServiceModel, Error>) -> Void)
    func modifyDiplomaDetails(studentID: Int, bachelor: Bool, model: DiplomaDetailsServiceModel, completion: @escaping (Result<Data?, Error>) -> Void)
}

class DiplomasInfoService: DiplomasInfoServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: DiplomasInfoURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: DiplomasInfoURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getDiplomas(bachelor: Bool, completion: @escaping (Result<DiplomasModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getDiplomas(bachelor: bachelor)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getDiplomaDetails(studentID: Int, completion: @escaping (Result<DiplomaInfoServiceModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getDiplomaDetails(studentID: studentID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func modifyDiplomaDetails(studentID: Int, bachelor: Bool, model: DiplomaDetailsServiceModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.modifyDiplomaDetails(studentID: studentID, bachelor: bachelor, model: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
