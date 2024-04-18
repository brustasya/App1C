//
//  NetworkService.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

class NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func handleStatusCode(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        switch httpResponse.statusCode {
        case (100...299):
            return
            
        case (300...399):
            throw TFSError.redirect

        case (400...499):
            throw TFSError.badRequest

        case (500...599):
            throw TFSError.serverError

        default:
            throw TFSError.unexpectedStatus
        }
    }
    
    private func errorLog(data: Data) {
        do {
            let errorModel = try JSONDecoder().decode(ErrorModel.self, from: data)
            Logger.shared.printLog(log: errorModel.message)
        } catch { }
    }
}

extension NetworkService: NetworkServiceProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(TFSError.noData))
                return
            }
            
            do {
                try self?.handleStatusCode(response: response)
                
                let model = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(model))
            } catch {
                self?.errorLog(data: data)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(TFSError.noData))
                return
            }
            
            do {
                try self?.handleStatusCode(response: response)
                completion(.success(nil))
            } catch {
                self?.errorLog(data: data)
                completion(.failure(error))
            }
        }.resume()
    }
}
