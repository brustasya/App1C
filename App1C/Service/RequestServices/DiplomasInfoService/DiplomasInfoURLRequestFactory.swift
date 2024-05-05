//
//  DiplomasInfoURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomasInfoURLRequestFactory: AnyObject {
    func getDiplomas(bachelor: Bool) throws -> URLRequest
}

extension URLRequestFactory: DiplomasInfoURLRequestFactory {
    func getDiplomas(bachelor: Bool) throws -> URLRequest {
        guard let url = url(with: "/diplomas", query: "bachelor=\(bachelor)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
}
