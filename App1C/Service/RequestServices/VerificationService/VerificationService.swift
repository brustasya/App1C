//
//  VerificationService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol VerificationServiceProtocol {
    func verification(with model: VerificationModel, completion: @escaping (Result<RolesModel, Error>) -> Void)
    func authorize(with model: AuthorizeModel, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
    func refresh(with model: RefreshModel, completion: @escaping (Result<TokenResponseModel, Error>) -> Void)
}

class VerificationService: VerificationServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: VerificationURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: VerificationURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func verification(with model: VerificationModel, completion: @escaping (Result<RolesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.verification(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func authorize(with model: AuthorizeModel, completion: @escaping (Result<TokenResponseModel, Error>) -> Void) {
        do {
            let request = try requestFactory.authorize(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func refresh(with model: RefreshModel, completion: @escaping (Result<TokenResponseModel, Error>) -> Void) {
        do {
            let request = try requestFactory.refresh(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}

