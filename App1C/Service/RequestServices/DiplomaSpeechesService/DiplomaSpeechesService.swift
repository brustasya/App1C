//
//  DiplomaSpeechesService.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaSpeechesServiceProtocol: AnyObject {
    func getSpeeches(type: String, bachelor: Bool, completion: @escaping (Result<DiplomaSpeechesModel, Error>) -> Void)
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
}
