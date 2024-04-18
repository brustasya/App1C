//
//  VerificationURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol VerificationURLRequestFactory: AnyObject {
    func verification(with model: VerificationModel) throws -> URLRequest
    func authorize(with model: AuthorizeModel) throws -> URLRequest
    func refresh(with model: RefreshModel) throws -> URLRequest
}

extension URLRequestFactory: VerificationURLRequestFactory {
    func verification(with model: VerificationModel) throws -> URLRequest {
        guard let url = url(with: "/verification"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
    
    func authorize(with model: AuthorizeModel) throws -> URLRequest {
        guard let url = url(with: "/verification/authorize"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
    
    func refresh(with model: RefreshModel) throws -> URLRequest {
        guard let url = url(with: "/verification/refresh"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
}
