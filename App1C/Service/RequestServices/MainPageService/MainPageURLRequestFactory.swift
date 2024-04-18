//
//  MainPageURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol MainPageURLRequestFactory: AnyObject {
    func getMain() throws -> URLRequest
    func updateLinks(with model: LinksModel) throws -> URLRequest
}

extension URLRequestFactory: MainPageURLRequestFactory {
    func getMain() throws -> URLRequest {
        guard let url = url(with: "/main") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func updateLinks(with model: LinksModel) throws -> URLRequest {
        guard let url = url(with: "/update-links"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
}
